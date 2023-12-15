resource "keycloak_user" "argocd-proj-hello-world" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "argocd-proj-hello-world"
  enabled        = true
  email          = "argocd-proj-hello-world@sikademo.com"
  email_verified = true
  first_name     = "argocd-proj-hello-world"
  last_name      = "argocd-proj-hello-world"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "argocd-proj-hello-world" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.argocd-proj-hello-world.id
  group_ids = [
    keycloak_group.argocd-proj-hello-world.id,
  ]
}
