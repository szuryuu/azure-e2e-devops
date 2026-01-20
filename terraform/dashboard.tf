resource "azurerm_portal_dashboard" "main" {
  name                = "${var.project_name}-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  tags = {
    project_name = var.project_name
    source       = "terraform"
  }

  dashboard_properties = templatefile("${path.module}/dashboard.tpl", {
    md_content = "Variable content here!",
    video_link = "https://www.youtube.com/watch?v=......",
    sub_id     = data.azurerm_subscription.current.subscription_id
  })
}
