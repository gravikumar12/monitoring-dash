resource "google_monitoring_dashboard" "bq_dashboard" {
  dashboard_json = <<EOF
{
  "displayName": "BigQuery Rows Inserted",
  "widgets": [
    {
      "title": "Rows Inserted into BigQuery",
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"logging.googleapis.com/user/bigquery_row_inserts\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }
        ]
      }
    }
  ]
}
EOF
}
