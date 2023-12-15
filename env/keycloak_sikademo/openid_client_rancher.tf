resource "keycloak_openid_client" "rancher" {
  realm_id                     = keycloak_realm.sikademo.id
  client_id                    = "rancher"
  name                         = "rancher"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "rancher"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
  valid_post_logout_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "rancher" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.rancher.id
  name      = "audience-mapper"

  included_client_audience = keycloak_openid_client.rancher.client_id
  add_to_access_token      = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "rancher" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.rancher.id
  name      = "group-membership-mapper"

  claim_name      = "full_group_path"
  full_path       = true
  add_to_userinfo = true
}

resource "keycloak_openid_client_default_scopes" "rancher" {
  realm_id  = keycloak_realm.sikademo.id
  client_id = keycloak_openid_client.rancher.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikademo_groups.name,
    keycloak_openid_group_membership_protocol_mapper.rancher.claim_name,
  ]
}
