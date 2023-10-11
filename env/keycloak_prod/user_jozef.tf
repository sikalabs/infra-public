resource "keycloak_user" "jozefvojtek" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "jozefvojtek"
  enabled        = true
  email          = "jozef.vojtek@sikalabs.com"
  email_verified = true
  first_name     = "Jozef"
  last_name      = "Vojtek"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "jozefvojtek" {
  realm_id = keycloak_realm.sikalabs.id
  user_id  = keycloak_user.jozefvojtek.id
  group_ids = [
    keycloak_group.argocd-admin.id,
    keycloak_group.cra-admins.id,
  ]
}
