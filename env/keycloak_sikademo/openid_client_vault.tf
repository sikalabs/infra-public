resource "keycloak_openid_client" "vault" {
  realm_id                     = keycloak_realm.sikademo.id
  client_id                    = "vault"
  name                         = "vault"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "vault"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "vault" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.vault.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikademo_groups.name,
  ]
}
