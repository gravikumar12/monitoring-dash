resource "google_logging_metric" "bq_rows_inserted" {
  name   = "bigquery_row_inserts"
  filter = "resource.type=\"bigquery_resource\" AND protoPayload.methodName=\"tabledata.insertAll\""

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }

  label_extractors = {
    "dataset_id" = "EXTRACT(protoPayload.resourceName, 'projects/[^/]+/datasets/([^/]+)')"
  }
}
