resource "keycloak_user" "okd_admin" {
  realm_id       = keycloak_realm.sikademo.id
  username       = "okd-admin"
  enabled        = true
  email          = "okd-admin@sikademo.com"
  email_verified = true
  first_name     = "OKD"
  last_name      = "Admin"
  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_groups" "okd_admin" {
  realm_id = keycloak_realm.sikademo.id
  user_id  = keycloak_user.okd_admin.id
  group_ids = [
    keycloak_group.okd_admin.id,
  ]
}
