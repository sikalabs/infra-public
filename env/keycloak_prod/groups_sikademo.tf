resource "keycloak_group" "sikademo_argocd_admin" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-admin"
}
