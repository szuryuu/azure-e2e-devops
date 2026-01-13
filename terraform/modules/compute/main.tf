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
    type = "SystemAssign"
  }

  custom_data = base64encode(local.custom)

  tags = {
    project_name = var.project_name
  }
}

locals {
  custom = <<EOF

  #!/bin/bash

  curl -sL https://aka.ms/InstallAzureCLIDeb | bash
  az login --identity
  az acr login --name ${var.acr_name}

  EOF
}
