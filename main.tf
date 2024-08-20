resource "google_monitoring_dashboard" "bq_dashboard" {
  dashboard_json = <<EOF
{
  "displayName": "BigQuery Monitoring Dashboard",
  "gridLayout": {
    "columns": 2,
    "widgets": [
      {
        "title": "BigQuery Load Errors",
        "xyChart": {
          "dataSets": [
            {
              "timeSeriesQuery": {
                "timeSeriesFilter": {
                  "filter": "metric.type=\"logging.googleapis.com/user/bigquery_load_errors\"",
                  "aggregation": {
                    "alignmentPeriod": "60s",
                    "perSeriesAligner": "ALIGN_DELTA"
                  }
                }
              },
              "plotType": "LINE"
            }
          ],
          "yAxis": {
            "label": "Error Count",
            "scale": "LINEAR"
          }
        }
      },
      {
        "title": "Rows Inserted into BigQuery Dataset",
        "xyChart": {
          "dataSets": [
            {
              "timeSeriesQuery": {
                "timeSeriesFilter": {
                  "filter": "metric.type=\"logging.googleapis.com/user/bigquery_row_inserts\"",
                  "aggregation": {
                    "alignmentPeriod": "60s",
                    "perSeriesAligner": "ALIGN_DELTA"
                  }
                }
              },
              "plotType": "LINE"
            }
          ],
          "yAxis": {
            "label": "Row Count",
            "scale": "LINEAR"
          }
        }
      }
    ]
  }
}
EOF
}
