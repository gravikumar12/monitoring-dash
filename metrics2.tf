resource "google_logging_metric" "bigquery_row_inserts_total" {
  name   = "bigquery_row_inserts_total"
  filter = <<EOT
resource.type="bigquery_resource"
protoPayload.methodName="jobservice.jobcompleted"
protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.tableId!="__TABLES__"
protoPayload.serviceData.jobCompletedEvent.job.jobStatistics.totalRows!="null"
EOT

  metric_descriptor {
    metric_kind = "DELTA"  # Use DELTA for logs-based metrics
    value_type  = "INT64"
    unit        = "1"
    display_name = "Total Rows Inserted into BigQuery"

    labels {
      key         = "project_id"
      value_type  = "STRING"
      description = "The project ID where the rows were inserted."
    }

    labels {
      key         = "dataset_id"
      value_type  = "STRING"
      description = "The dataset ID where the rows were inserted."
    }

    labels {
      key         = "table_id"
      value_type  = "STRING"
      description = "The table ID where the rows were inserted."
    }
  }

  label_extractors = {
    "project_id" = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.projectId)"
    "dataset_id" = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.datasetId)"
    "table_id"   = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.tableId)"
  }
}
