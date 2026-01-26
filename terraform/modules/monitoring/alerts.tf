resource "azurerm_monitor_action_group" "main" {
  name                = "${var.project_name}-actiongroup"
  resource_group_name = var.resource_group_name
  short_name          = "e2eact"

  email_receiver {
    name          = "admin-alert"
    email_address = "ilhamdzaky2007@gmail.com"
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_metric_alert" "vm_cpu" {
  name                = "${var.project_name}-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = var.vm_id
  description         = "Alert if CPU > 20%"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 20
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
