resource "google_monitoring_alert_policy" "bq_load_errors_alert" {
  display_name = "BigQuery Load Errors Alert"

  conditions {
    display_name = "BigQuery Load Error Rate"
    condition_threshold {
      # Include resource type restriction in the filter
      #filter = "metric.type=\"logging.googleapis.com/user/bigquery_load_errors\""
      filter = "metric.type=\"logging.googleapis.com/user/bigquery_load_errors\" AND resource.type=\"global\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"

      aggregations {
        alignment_period    = "60s"
        per_series_aligner  = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [""]

  combiner = "OR"
  enabled  = true

  documentation {
    content  = "This alert triggers when there are errors loading data into BigQuery."
    mime_type = "text/markdown"
  }
}
