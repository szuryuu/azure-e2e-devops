# Azure
variable "resource_group_name" {
  type = string
}

# Project
variable "project_name" {
  type = string
}

variable "location" {
  type = string
}

output "action_group_id" {
  value = azurerm_monitor_action_group.main.id
}
