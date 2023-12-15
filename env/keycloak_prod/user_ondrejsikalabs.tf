resource "keycloak_user" "ondrejsikalabs" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "ondrejsikalabs"
  enabled        = true
  email          = "ondrej@sikalabs.com"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "ondrejsikalabs" {
  realm_id = keycloak_realm.sikalabs.id
  user_id  = keycloak_user.ondrejsikalabs.id
  group_ids = [
    keycloak_group.argocd-admin.id,
    keycloak_group.harbor-admins.id,
  ]
}
