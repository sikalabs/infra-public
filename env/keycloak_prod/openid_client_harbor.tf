variable "keycloak_openid_client_harbor_client_secret" {}

resource "keycloak_openid_client" "harbor" {
  realm_id                     = keycloak_realm.sikalabs.id
  client_id                    = "harbor"
  name                         = "harbor"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = var.keycloak_openid_client_harbor_client_secret
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "harbor" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.harbor.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
