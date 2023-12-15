resource "keycloak_user" "sikademo_argocd" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "argocd"
  enabled        = true
  email          = "argocd@sikademo.com"
  email_verified = true
  first_name     = "ArgoCD"
  last_name      = "ArgoCD"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "sikademo_argocd" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.sikademo_argocd.id
  group_ids = [
    keycloak_group.sikademo_argocd_admin.id,
  ]
}
