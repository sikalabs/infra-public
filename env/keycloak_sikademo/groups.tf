resource "keycloak_group" "argocd-admin" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-admin"
}

resource "keycloak_group" "argocd-readonly" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-readonly"
}

resource "keycloak_group" "argocd-proj-hello-world" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-proj-hello-world"
}

resource "keycloak_group" "argocd-foo" {
  realm_id = keycloak_realm.sikademo.id
  name     = "argocd-foo"
}

resource "keycloak_group" "vault-admin" {
  realm_id = keycloak_realm.sikademo.id
  name     = "vault-admin"
}

resource "keycloak_group" "okd_admin" {
  realm_id = keycloak_realm.sikademo.id
  name     = "okd-admin"
}
