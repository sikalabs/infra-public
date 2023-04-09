// https://app.terraform.io/app/sikalabs/workspaces/infra-public--do_dev

terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--homeatcloud_prod"
    }
  }
}
