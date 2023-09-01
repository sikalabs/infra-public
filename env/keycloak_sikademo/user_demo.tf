resource "keycloak_user" "demo" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "demo"
  enabled        = true
  email          = "demo@sikademo.com"
  email_verified = true
  first_name     = "Demo"
  last_name      = "Demo"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "demo" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.demo.id
  group_ids = [
    keycloak_group.argocd-admin.id,
  ]
}
