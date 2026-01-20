{
  "properties": {
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
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
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart"
            },
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
                        "namespace": "Microsoft.Compute/virtualMachines",
                        "metricVisualization": {
                          "displayName": "CPU Usage (%)",
                          "resourceDisplayName": "${vm_name}"
                        }
                      }
                    ],
                    "title": "CPU Usage (Last 1 Hour)",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2,
                      "legendVisualization": {
                        "isVisible": true,
                        "position": 2,
                        "hideSubtitle": false
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
          },
          "1": {
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
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart"
            },
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${vm_id}"
                        },
                        "name": "Network In",
                        "aggregationType": 1,
                        "namespace": "Microsoft.Compute/virtualMachines",
                        "metricVisualization": {
                          "displayName": "Network In"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${vm_id}"
                        },
                        "name": "Network Out",
                        "aggregationType": 1,
                        "namespace": "Microsoft.Compute/virtualMachines",
                        "metricVisualization": {
                          "displayName": "Network Out"
                        }
                      }
                    ],
                    "title": "Network Traffic",
                    "titleKind": 1,
                    "visualization": {
                      "chartType": 2
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
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
        }
      }
    }
  }
}
