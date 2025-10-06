provider "google" {
  project = "your-project-id"
  region  = "your-region"
}

# Create monitoring dashboard
resource "google_monitoring_dashboard" "example" {
  dashboard_json = <<EOF
{
  "displayName": "GKE Cluster Metrics",
  "gridLayout": {
    "columns": 2,
    "rows": 2
  },
  "widgets": [
    {
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesFilter": {
              "filter": "metric.type=\"kubernetes.io/container/cpu/core_usage_time\" resource.type=\"k8s_container\"",
              "aggregation": {
                "perSeriesAligner": "ALIGN_MEAN"
              }
            }
          }
        ],
        "xAxis": {
          "title": "Time"
        },
        "yAxis": {
          "title": "CPU Usage"
        }
      }
    },
    {
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesFilter": {
              "filter": "metric.type=\"kubernetes.io/container/memory/used_bytes\" resource.type=\"k8s_container\"",
              "aggregation": {
                "perSeriesAligner": "ALIGN_MEAN"
              }
            }
          }
        ],
        "xAxis": {
          "title": "Time"
        },
        "yAxis": {
          "title": "Memory Usage"
        }
      }
    }
  ]
}
EOF
}
