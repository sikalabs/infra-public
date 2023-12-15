resource "keycloak_openid_client" "gitlab_sikademo" {
  realm_id                     = keycloak_realm.sikalabs.id
  client_id                    = "gitlab-sikademo"
  name                         = "gitlab-sikademo"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  client_secret                = "gitlab-sikademo"
  standard_flow_enabled        = true
  direct_access_grants_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_client_default_scopes" "gitlab_sikademo" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.gitlab_sikademo.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
