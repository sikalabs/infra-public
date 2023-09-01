resource "keycloak_user" "argocd-readonly" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "argocd-readonly"
  enabled        = true
  email          = "argocd-readonly@sikademo.com"
  email_verified = true
  first_name     = "argocd-readonly"
  last_name      = "argocd-readonly"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "argocd-readonly" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.argocd-readonly.id
  group_ids = [
    keycloak_group.argocd-readonly.id,
  ]
}
