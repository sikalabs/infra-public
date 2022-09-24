terraform {
  backend "remote" {
    organization = "sikalabs"
    workspaces {
      name = "infra-public--do_dev"
    }
  }
}
