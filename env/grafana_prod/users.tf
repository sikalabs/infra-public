variable "ondrej_password" {}

resource "grafana_user" "ondrej-admin" {
  email    = "ondrej+admin@sika.io"
  name     = "Ondrej Sika"
  login    = "ondrej-admin"
  password = var.ondrej_password
  is_admin = true
}

resource "grafana_user" "ondrej" {
  email    = "ondrej@sika.io"
  name     = "Ondrej Sika"
  login    = "ondrej"
  password = var.ondrej_password
  is_admin = false
}
