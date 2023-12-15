resource "keycloak_user" "argocd-foo" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "argocd-foo"
  enabled        = true
  email          = "argocd-foo@sikademo.com"
  email_verified = true
  first_name     = "argocd-foo"
  last_name      = "argocd-foo"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "argocd-foo" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.argocd-foo.id
  group_ids = [
    keycloak_group.argocd-foo.id,
  ]
}
