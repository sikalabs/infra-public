locals {
  MINIO_IP = "194.213.36.173"
}

module "minio" {
  source        = "../../../modules/core/openstack_vm"
  name          = "sl-prod-minio"
  image_id      = "f97b70b4-8c03-455f-bc6a-24717fd664aa"
  key_pair_name = openstack_compute_keypair_v2.ondrejsika.name
  volume_size   = 500
  flavor_id     = local.FLAVORS.FLAVOR_2CPU_2RAM
  network_interfaces = [
    {
      name        = "default"
      fixed_ip_v4 = "10.54.81.21"
    },
  ]

  security_groups = [
    "default",
  ]
}

resource "openstack_compute_floatingip_associate_v2" "minio" {
  floating_ip = local.MINIO_IP
  instance_id = module.minio.instance_id
}
