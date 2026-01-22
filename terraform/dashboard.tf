resource "azurerm_portal_dashboard" "main" {
  name                = "${var.project_name}-dashboard"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  tags = {
    project_name = var.project_name
    source       = "terraform"
    hidden-title = "Dashboard"
  }

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {
          "0" = {
            position = {
              x       = 0
              y       = 0
              colSpan = 6
              rowSpan = 4
            }
            metadata = {
              inputs = [
                {
                  name  = "resourceType"
                  value = "Microsoft.Compute/virtualMachines"
                },
                {
                  name  = "resourceId"
                  value = module.compute.vm_id
                },
                {
                  name       = "options"
                  isOptional = true
                },
                {
                  name       = "sharedTimeRange"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = module.compute.vm_id
                          }
                          name            = "Percentage CPU"
                          aggregationType = 4
                          namespace       = "microsoft.compute/virtualmachines"
                          metricVisualization = {
                            displayName         = "Percentage CPU"
                            resourceDisplayName = module.compute.vm_name
                          }
                        }
                      ]
                      title     = "Avg Percentage CPU for ${module.compute.vm_name}"
                      titleKind = 1
                      visualization = {
                        chartType = 3
                        legendVisualization = {
                          isVisible      = true
                          position       = 2
                          hideHoverCard  = false
                          hideLabelNames = true
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                        disablePinning = true
                      }
                    }
                  }
                }
              }
            }
          }
          "1" = {
            position = {
              x       = 6
              y       = 0
              colSpan = 6
              rowSpan = 4
            }
            metadata = {
              inputs = [
                {
                  name  = "resourceType"
                  value = "Microsoft.Compute/virtualMachines"
                },
                {
                  name  = "resourceId"
                  value = module.compute.vm_id
                },
                {
                  name       = "options"
                  isOptional = true
                },
                {
                  name       = "sharedTimeRange"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = module.compute.vm_id
                          }
                          name            = "Network In Total"
                          aggregationType = 4
                          namespace       = "microsoft.compute/virtualmachines"
                          metricVisualization = {
                            displayName         = "Network In Total"
                            resourceDisplayName = module.compute.vm_name
                          }
                        },
                        {
                          resourceMetadata = {
                            id = module.compute.vm_id
                          }
                          name            = "Network Out Total"
                          aggregationType = 4
                          namespace       = "microsoft.compute/virtualmachines"
                          metricVisualization = {
                            displayName         = "Network Out Total"
                            resourceDisplayName = module.compute.vm_name
                          }
                        }
                      ]
                      title     = "Network Traffic for ${module.compute.vm_name}"
                      titleKind = 1
                      visualization = {
                        chartType = 3
                        legendVisualization = {
                          isVisible      = true
                          position       = 2
                          hideHoverCard  = false
                          hideLabelNames = false
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                        disablePinning = true
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    metadata = {
      model = {
        timeRange = {
          value = {
            relative = {
              duration = 24
              timeUnit = 1
            }
          }
          type = "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        }
        filterLocale = {
          value = "en-us"
        }
        filters = {
          value = {
            MsPortalFx_TimeRange = {
              model = {
                format      = "local"
                granularity = "auto"
                relative    = "30m"
              }
              displayCache = {
                name  = "Local Time"
                value = "Past 30 minutes"
              }
              filteredPartIds = [
                "StartboardPart-MonitorChartPart-0",
                "StartboardPart-MonitorChartPart-1"
              ]
            }
          }
        }
      }
    }
  })
}
