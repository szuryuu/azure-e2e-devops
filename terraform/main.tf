terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_key_vault_secret" "ssh" {
  name         = "ssh-public-keys"
  key_vault_id = data.azurerm_key_vault.main.id
}

# ACR
resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}acr${random_string.random.result}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "vm_pull_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.compute.vm_principal_id
}

resource "random_string" "random" {
  length  = 3
  special = false
  upper   = false
}

# Modules
module "network" {
  source              = "./modules/network"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  project_name     = var.project_name
  address_space    = var.address_space
  address_prefixes = var.address_prefixes
  allowed_ip       = var.allowed_ip
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  project_name = var.project_name
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  vm_size             = var.vm_size

  project_name          = var.project_name
  ssh_public_key        = data.azurerm_key_vault_secret.ssh.value
  network_interface_ids = module.network.vm_nic

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  acr_name                   = azurerm_container_registry.acr.name


  depends_on = [module.network, module.monitoring]
}
