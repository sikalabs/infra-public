resource "keycloak_user" "ondrejsika_ondrejsika" {
  realm_id       = keycloak_realm.ondrejsika.id
  username       = "ondrejsika"
  enabled        = true
  email          = "ondrejsika@ondrejsika.com"
  email_verified = true
  first_name     = "Ondrej"
  last_name      = "Sika"
  initial_password {
    value     = var.user_initial_password
    temporary = true
  }
}

# resource "keycloak_user_groups" "ondrejsika_ondrejsika" {
#   realm_id  = keycloak_realm.sikalabs.id
#   user_id   = keycloak_user.ondrejsika_ondrejsika.id
#   group_ids = []
# }
