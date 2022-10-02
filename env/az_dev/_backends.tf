// https://app.terraform.io/app/sikalabs/workspaces/infra-public--az_dev

terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--az_dev"
    }
  }
}
