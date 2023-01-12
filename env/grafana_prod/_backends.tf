// https://app.terraform.io/app/sikalabs/workspaces/infra-public--grafana_prod

terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--grafana_prod"
    }
  }
}
