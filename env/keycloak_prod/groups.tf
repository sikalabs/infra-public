resource "keycloak_group" "grafana-admin" {
  realm_id = keycloak_realm.sikalabs.id
  name     = "grafana-admin"
}

resource "keycloak_group" "grafana-dev" {
  realm_id = keycloak_realm.sikalabs.id
  name     = "grafana-dev"
}
