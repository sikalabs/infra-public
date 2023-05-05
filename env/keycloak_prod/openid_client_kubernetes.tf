resource "keycloak_openid_client" "kubernetes_rke2_single_node" {
  realm_id              = keycloak_realm.sikalabs.id
  client_id             = "kubernetes-rke2-single-node"
  name                  = "kubernetes-rke2-single-node"
  enabled               = true
  access_type           = "PUBLIC"
  standard_flow_enabled = true
  valid_redirect_uris = [
    "*",
  ]
}

resource "keycloak_openid_audience_protocol_mapper" "kubernetes_rke2_single_node" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.kubernetes_rke2_single_node.id
  name      = "audience-mapper"
included_client_audience = keycloak_openid_client.kubernetes_rke2_single_node.client_id
}

resource "keycloak_openid_client_default_scopes" "kubernetes_rke2_single_node" {
  realm_id  = keycloak_realm.sikalabs.id
  client_id = keycloak_openid_client.kubernetes_rke2_single_node.id
  default_scopes = [
    "profile",
    "email",
    keycloak_openid_client_scope.sikalabs_groups.name,
  ]
}
