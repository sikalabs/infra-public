resource "keycloak_openid_client" "freshdesk" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "freshdesk"
  name                  = "z6aq_VqQr_aKCS_roaH"
  enabled               = true
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "freshdesk" {
  realm_id                 = keycloak_realm.sikalabs.id
  client_id                = keycloak_openid_client.freshdesk.id
  name                     = "audience-mapper"
  included_client_audience = keycloak_openid_client.freshdesk.client_id
}

resource "keycloak_openid_client_default_scopes" "freshdesk" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.freshdesk.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
