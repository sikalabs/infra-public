terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "cloudflare_api_token" {}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "digitalocean_token" {}
provider "digitalocean" {
  token = var.digitalocean_token
}
