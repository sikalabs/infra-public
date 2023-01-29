resource "keycloak_user" "grafana-admin" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "grafana-admin"
  enabled        = true
  email          = "grafana-admin@sikalabs.io"
  email_verified = true
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "grafana-admin" {
  realm_id = keycloak_realm.sikalabs.id
  user_id  = keycloak_user.grafana-admin.id
  group_ids = [
    keycloak_group.grafana-admin.id,
  ]
}
