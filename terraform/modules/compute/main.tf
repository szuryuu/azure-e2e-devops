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
  custom = <<EOF

  #!/bin/bash

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

  EOF
}
