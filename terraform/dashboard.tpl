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
                      "namespace": "microsoft.compute/virtualmachines",
                      "metricVisualization": {
                        "displayName": "CPU Usage (%)",
                        "resourceDisplayName": "${vm_name}"
                      }
                    }
                  ],
                  "title": "CPU Usage",
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
                "isOptional":  true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
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
                      "name": "Network In Total",
                      "aggregationType": 4,
                      "namespace": "Microsoft.Compute/virtualMachines",
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
                  "title": "Network Traffic",
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
