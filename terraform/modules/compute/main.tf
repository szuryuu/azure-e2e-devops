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

  custom_data = base64encode(templatefile("${path.module}/cloud-init.yml", {
    acr_name                       = var.acr_name
    app_insights_connection_string = var.app_insights_connection_string
  }))

  tags = {
    project_name = var.project_name
  }
}

resource "azurerm_virtual_machine_extension" "ama" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.main.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.2"
  auto_upgrade_minor_version = true
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

    azure_monitor_metrics {
      name = "law-destination-metrics"
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["law-destination-metrics"]
  }

  data_flow {
    streams      = ["Microsoft-Syslog", "Microsoft-Perf"]
    destinations = ["law-destination-log"]
  }

  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "law-datasource-syslog"
      streams        = ["Microsoft-Syslog"]
    }

    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\Available Bytes",
        "\\Memory\\% Committed Bytes In Use",
        "\\LogicalDisk(_Total)\\% Free Space"
      ]
      name = "datasource-perf"
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "${var.project_name}-dcra"
  target_resource_id      = azurerm_linux_virtual_machine.main.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}
