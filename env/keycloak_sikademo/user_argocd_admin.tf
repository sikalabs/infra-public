resource "keycloak_user" "argocd-admin" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "argocd-admin"
  enabled        = true
  email          = "argocd-admin@sikademo.com"
  email_verified = true
  first_name     = "argocd-admin"
  last_name      = "argocd-admin"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "argocd-admin" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.argocd-admin.id
  group_ids = [
    keycloak_group.argocd-admin.id,
  ]
}
