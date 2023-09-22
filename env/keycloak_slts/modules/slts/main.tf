terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
    }
  }
}

variable "name" {}
variable "users" {}
variable "initial_password" {}

resource "keycloak_realm" "main" {
  realm                    = var.name
  enabled                  = true
  display_name_html        = "<h1>SLTS ${var.name} SSO</h1>"
  login_with_email_allowed = true
  reset_password_allowed   = true
  remember_me              = true
}

resource "keycloak_openid_client" "tailscale" {
  realm_id                     = keycloak_realm.main.id
  client_id                    = "tailscale"
  name                         = "tailscale"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "tailscale"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_user" "users" {
  for_each = var.users

  realm_id       = keycloak_realm.main.id
  username       = each.key
  enabled        = true
  email          = each.value.email
  email_verified = true
  first_name     = each.value.first_name
  last_name      = each.value.last_name
  initial_password {
    value     = var.initial_password
    temporary = true
  }
}
