{
    "lenses": [
      {
        "order": 0,
        "parts": [
          {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceType",
                  "value": "Microsoft.Compute/virtualMachines"
                },
                {
                  "name": "resourceId",
                  "value": "${vm_id}"
                },
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${vm_id}"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Percentage CPU",
                            "resourceDisplayName": "${vm_name}"
                          }
                        }
                      ],
                      "title": "Avg Percentage CPU for ${vm_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 3,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideHoverCard": false,
                          "hideLabelNames": true
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceType",
                  "value": "Microsoft.Compute/virtualMachines"
                },
                {
                  "name": "resourceId",
                  "value": "${vm_id}"
                },
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${vm_id}"
                          },
                          "name": "Network In Total",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Network In Total",
                            "resourceDisplayName": "${vm_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${vm_id}"
                          },
                          "name": "Network Out Total",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Network Out Total",
                            "resourceDisplayName": "${vm_name}"
                          }
                        }
                      ],
                      "title": "Avg Network In Total and Avg Network Out Total for ${vm_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 3,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideHoverCard": false,
                          "hideLabelNames": true
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          }
        ]
      }
    ],
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "local",
                "granularity": "auto",
                "relative": "30m"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past 30 minutes"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-5e16d2c3-ba46-4aca-8041-4388bd92c00e",
                "StartboardPart-MonitorChartPart-5e16d2c3-ba46-4aca-8041-4388bd92c010"
              ]
            }
          }
        }
      }
    }
  },
  "name": "${vm_name}-dashboard",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "${vm_name}-dashboard"
  },
}
