// https://app.terraform.io/app/sikalabs/workspaces/infra-public--keycloak_prod

terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--keycloak_prod"
    }
  }
}
