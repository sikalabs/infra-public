// https://app.terraform.io/app/sikalabs/workspaces/infra-public--do_prod_new

terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--do_prod_new"
    }
  }
}
