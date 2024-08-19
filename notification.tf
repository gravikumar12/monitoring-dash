resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Email Notification Channel"
  type         = "email"

  labels = {
    email_address = "your-email@example.com"
  }
}
