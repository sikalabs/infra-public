resource "keycloak_user" "sikademo_ondrej" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "ondrej"
  enabled        = true
  email          = "ondrej@sikademo.com"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "sikademo_ondrej" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.sikademo_ondrej.id
  group_ids = [
    keycloak_group.sikademo_argocd_admin.id,
  ]
}
