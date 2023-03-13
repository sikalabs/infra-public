resource "keycloak_group" "grafana-admin" {
  realm_id = keycloak_realm.sikalabs.id
  name     = "grafana-admin"
}

resource "keycloak_group" "grafana-dev" {
  realm_id = keycloak_realm.sikalabs.id
  name     = "grafana-dev"
}

resource "keycloak_group" "argocd-admin" {
  realm_id = keycloak_realm.sikalabs.id
  name     = "argocd-admin"
}