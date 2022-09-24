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

variable "droplet_name" {}
variable "record_name" {}
variable "image" {}
variable "region" {}
variable "size" {}
variable "user_data" {}
variable "zone_id" {}
variable "ssh_keys" {}
variable "vpc_uuid" {}

resource "digitalocean_droplet" "this" {
  image     = var.image
  name      = var.droplet_name
  region    = var.region
  size      = var.size
  user_data = var.user_data
  vpc_uuid  = var.vpc_uuid
  ssh_keys  = var.ssh_keys
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.record_name
  value   = digitalocean_droplet.this.ipv4_address
  type    = "A"
  proxied = false
}

output "digitalocean_droplet" {
  value = digitalocean_droplet.this
}

output "cloudflare_record" {
  value = cloudflare_record.this
}
