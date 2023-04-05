variable "keycloak_openid_client_oauth2_proxy_ondrej_client_secret" {}

resource "keycloak_openid_client" "oauth2_proxy_ondrej" {
  realm_id                     = keycloak_realm.sikalabs.id
  client_id                    = "oauth2_proxy_ondrej"
  name                         = "oauth2_proxy_ondrej"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = var.keycloak_openid_client_oauth2_proxy_ondrej_client_secret
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "oauth2_proxy_ondrej" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.oauth2_proxy_ondrej.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
