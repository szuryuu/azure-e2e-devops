resource "azurerm_monitor_metric_alert" "vm_cpu" {
  name                = "${var.project_name}-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [module.compute.vm_id]
  description         = "Alert if CPU > 20%"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 20
  }

  action {
    action_group_id = module.monitoring.action_group_id
  }
}
