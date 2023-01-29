variable "ondrej_password" {}

resource "grafana_user" "ondrej-admin" {
  email    = "ondrej+admin@sika.io"
  name     = "Ondrej Sika"
  login    = "ondrej-admin"
  password = var.ondrej_password
  is_admin = true
}

resource "grafana_user" "ondrej" {
  lifecycle {
    ignore_changes = [
      name,
    ]
  }
  email    = "ondrej@sika.io"
  login    = "ondrej@sika.io"
  is_admin = false
  password = var.ondrej_password
}
