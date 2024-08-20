resource "google_logging_metric" "bq_load_errors" {
  name   = "bigquery_load_errors"
  filter = <<EOT
resource.type="bigquery_resource"
protoPayload.methodName="jobservice.jobcompleted"
protoPayload.status.message:("error" OR "failed")
EOT

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"

    labels {
      key         = "project_id"
      value_type  = "STRING"
      description = "The project ID where the error occurred"
    }

    labels {
      key         = "dataset_id"
      value_type  = "STRING"
      description = "The dataset ID where the error occurred"
    }

    labels {
      key         = "table_id"
      value_type  = "STRING"
      description = "The table ID where the error occurred"
    }
  }

  label_extractors = {
    "project_id" = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.projectId)"
    "dataset_id" = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.datasetId)"
    "table_id"   = "EXTRACT(protoPayload.serviceData.jobCompletedEvent.job.jobConfiguration.load.destinationTable.tableId)"
  }
}

