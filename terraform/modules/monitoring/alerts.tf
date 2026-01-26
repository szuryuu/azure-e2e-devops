resource "azurerm_monitor_action_group" "main" {
  name                = "${var.project_name}-actiongroup"
  resource_group_name = var.resource_group_name
  short_name          = "e2eact"
}

resource "azurerm_monitor_metric_alert" "main" {
  name                = "${var.project_name}-metricalert"
  resource_group_name = var.resource_group_name
  scopes              = var.vm_id

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
