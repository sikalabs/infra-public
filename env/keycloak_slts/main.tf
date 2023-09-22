variable "initial_password" {}

module "cnc" {
  source = "./modules/slts"

  name             = "cnc"
  initial_password = var.initial_password
  users = {
    "ondrej" = {
      email      = "ondrej@cnc.slts.uk"
      first_name = "Ondrej"
      last_name  = "Sika"
    }
    "vpn" = {
      email      = "vpn@cnc.slts.uk"
      first_name = "VPN"
      last_name  = "VPN"
    }
  }
}

module "ducr" {
  source = "./modules/slts"

  name             = "ducr"
  initial_password = var.initial_password
  users = {
    "ondrej" = {
      email      = "ondrej@ducr.slts.uk"
      first_name = "Ondrej"
      last_name  = "Sika"
    }
    "vpn" = {
      email      = "vpn@ducr.slts.uk"
      first_name = "VPN"
      last_name  = "VPN"
    }
  }
}
