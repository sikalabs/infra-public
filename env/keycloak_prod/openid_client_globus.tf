resource "keycloak_openid_client" "globus" {
  realm_id                     = keycloak_realm.sikalabs.id
  client_id                    = "globus"
  name                         = "globus"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "hutL_UPbF_1Mmw_hY06"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "globus" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.globus.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
