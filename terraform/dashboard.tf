resource "azurerm_portal_dashboard" "main" {
  name                = "${var.project_name}-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  tags = {
    project_name = var.project_name
    source       = "terraform"
  }

  dashboard_properties = templatefile("${path.module}/dashboard.tpl", {
    vm_id   = module.compute.vm_id
    vm_name = module.compute.vm_name
  })
}
