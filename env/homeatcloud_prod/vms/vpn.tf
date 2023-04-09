locals {
  VPN_IP = "194.213.36.178"
}

module "vpn" {
  source        = "../../../modules/core/openstack_vm"
  name          = "sl-prod-vpn"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = openstack_compute_keypair_v2.ondrejsika.name
  volume_size   = 5
  flavor_id     = "11"
  network_interfaces = [
    {
      name        = "network_f2d2d74cea2d4f34a7b06921f5a177fc"
      fixed_ip_v4 = "192.168.0.10"
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