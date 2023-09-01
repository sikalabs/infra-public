resource "keycloak_group" "argocd-admin" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-admin"
}

resource "keycloak_group" "argocd-readonly" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-readonly"
}
