resource "keycloak_user" "robertloukota" {
  realm_id       = keycloak_realm.sikalabs.id
  username       = "robertloukota"
  enabled        = true
  email          = "robert.loukota@cncenter.cz"
  email_verified = true
  first_name     = "Robert"
  last_name      = "Loukota"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

resource "keycloak_user_groups" "robertloukota" {
  realm_id  = keycloak_realm.sikalabs.id
  user_id   = keycloak_user.robertloukota.id
  group_ids = []
}
