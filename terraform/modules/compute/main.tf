resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.project_name}-vm"
  admin_username      = "adminuser"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size

  disable_password_authentication = true
  network_interface_ids           = var.network_interface_ids

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  custom_data = base64encode(local.custom)

  tags = {
    project_name = var.project_name
  }
}

locals {
  custom = <<-EOF
  #!/bin/bash
  set -e

  # Redirect logs
  exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

  # Docker
  apt-get update
  apt-get install -y docker.io

  # Az
  curl -sL https://aka.ms/InstallAzureCLIDeb | bash
  az login --identity
  az acr login --name ${var.acr_name}

  # Image
  IMAGE_TAG="${var.acr_name}.azurecr.io/my-webapp:latest"

  echo "waiting image $IMAGE_TAG..."
  until docker pull $IMAGE_TAG; do
    echo "Image not available. Retrying in 30s..."
    sleep 30
  done

  docker run -d -p 80:80 --name production-app $IMAGE_TAG

  sleep 5

  # Inject Connection String
  docker ecec production-app sed -i 's|CONNECTION_STRING|${var.app_insights_connection_string}|g' /usr/share/nginx/html/index.html

  EOF
}

resource "azurerm_virtual_machine_extension" "ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.12"
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "${var.project_name}-dcr"
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "law-destination-log"
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["law-destination-log"]
  }

  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "law-datasource-syslog"
      streams        = ["Microsoft-Syslog"]
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "${var.project_name}-dcra"
  target_resource_id      = azurerm_linux_virtual_machine.main.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}
