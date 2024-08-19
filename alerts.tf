resource "google_monitoring_alert_policy" "bq_row_insert_alert" {
  display_name = "BigQuery Row Insert Alert"
  combiner     = "OR"
  notification_channels = [google_monitoring_notification_channel.email_channel.id]

  conditions {
    display_name = "BigQuery Row Inserts Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/bigquery_row_inserts\""
      
      aggregations {
        alignment_period    = "60s"
        per_series_aligner  = "ALIGN_RATE"
      }

      comparison    = "COMPARISON_GT"
      threshold_value = 1000
      duration       = "60s"
    }
  }

  documentation {
    content = "Alert: High number of rows inserted into BigQuery table."
    mime_type = "text/markdown"
  }

  alert_strategy {
    auto_close = "3600s"
  }
}
