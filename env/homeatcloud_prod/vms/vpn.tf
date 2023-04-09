locals {
  VPN_IP = "194.213.36.18"
}

module "vpn" {
  source        = "../../../modules/core/openstack_vm"
  name          = "sl-prod-vpn"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = openstack_compute_keypair_v2.ondrejsika.name
  volume_size   = 5
  flavor_id     = local.FLAVORS.FLAVOR_1CPU_1RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.10"
    },
  ]

  security_groups = [
    "default",
  ]
}

resource "openstack_compute_floatingip_associate_v2" "vpn" {
  floating_ip = local.VPN_IP
  instance_id = module.vpn.instance_id
}
