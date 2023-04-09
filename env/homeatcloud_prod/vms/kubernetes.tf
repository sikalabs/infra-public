module "kubernetes--debora" {
  source = "./kubernetes/debora"

  FLAVORS      = local.FLAVORS
  ssh_key_name = openstack_compute_keypair_v2.ondrejsika.name
}
