resource "google_monitoring_dashboard" "bigquery_row_inserts_dashboard" {
  dashboard_json = jsonencode({
    "displayName" = "BigQuery Row Inserts Dashboard",
    "gridLayout" = {
      "columns" = 12,
      "widgets" = [
        {
          "title" = "BigQuery Row Inserts",
          "xyChart" = {
            "chartOptions" = {
              "mode" = 0
            },
            "dataSets" = [
              {
                "timeSeriesQuery" = {
                  "timeSeriesQueryLanguage" = "metric.type=\"logging.googleapis.com/user/bigquery_row_inserts_total\"",
                  "unitOverride" = "1"
                },
                "plotType" = "LINE"
              }
            ],
            "yAxis" = {
              "label" = "Rows",
              "scale" = "LINEAR"
            }
          }
        }
      ]
    }
  })
}
