resource "keycloak_user" "grafana-dev" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "grafana-dev"
  enabled        = true
  email          = "grafana-dev@sikalabs.io"
  email_verified = true
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "grafana-dev" {
  realm_id = keycloak_realm.sikalabs.id
  user_id  = keycloak_user.grafana-dev.id
  group_ids = [
    keycloak_group.grafana-dev.id,
  ]
}
