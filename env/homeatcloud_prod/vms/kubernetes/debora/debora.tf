variable "FLAVORS" {}
variable "ssh_key_name" {}

locals {
  DEBORA_IP = "194.213.36.178"
}

module "debora-proxy" {
  source        = "../../../../../modules/core/openstack_vm"
  name          = "sl-prod-debora-proxy"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = var.ssh_key_name
  volume_size   = 10
  flavor_id     = var.FLAVORS.FLAVOR_1CPU_1RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.50"
    },
  ]

  security_groups = [
    "default",
  ]
}

resource "openstack_compute_floatingip_associate_v2" "proxy" {
  floating_ip = local.DEBORA_IP
  instance_id = module.debora-proxy.instance_id
}

module "debora1" {
  source        = "../../../../../modules/core/openstack_vm"
  name          = "sl-prod-debora1"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = var.ssh_key_name
  volume_size   = 80
  flavor_id     = var.FLAVORS.FLAVOR_8CPU_8RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.51"
    },
  ]

  security_groups = [
    "default",
  ]
}

module "debora2" {
  source        = "../../../../../modules/core/openstack_vm"
  name          = "sl-prod-debora2"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = var.ssh_key_name
  volume_size   = 80
  flavor_id     = var.FLAVORS.FLAVOR_8CPU_8RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.52"
    },
  ]

  security_groups = [
    "default",
  ]
}

module "debora3" {
  source        = "../../../../../modules/core/openstack_vm"
  name          = "sl-prod-debora3"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = var.ssh_key_name
  volume_size   = 80
  flavor_id     = var.FLAVORS.FLAVOR_4CPU_4RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.53"
    },
  ]

  security_groups = [
    "default",
  ]
}
