locals {
  GITLAB_IP = "194.213.36.36"
}

module "gitlab" {
  source        = "../../../modules/core/openstack_vm"
  name          = "sl-prod-gitlab"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = openstack_compute_keypair_v2.ondrejsika.name
  volume_size   = 120
  flavor_id     = local.FLAVORS.FLAVOR_8CPU_8RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.20"
    },
  ]

  security_groups = [
    "default",
  ]
}

resource "openstack_compute_floatingip_associate_v2" "gitlab" {
  floating_ip = local.GITLAB_IP
  instance_id = module.gitlab.instance_id
}
