resource "keycloak_user" "ondrej" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "ondrej"
  enabled        = true
  email          = "ondrej@sika.io"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}
