resource "keycloak_user" "vojtech" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "vojtech"
  enabled        = true
  email          = "vojtech@sikalabs.com"
  email_verified = true
  first_name     = "Vojtech"
  last_name      = "Mares"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}
