module "vms" {
  source = "./vms"
}

resource "openstack_networking_network_v2" "default" {
  name           = "default"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "default" {
  network_id = openstack_networking_network_v2.default.id
  name       = "default"
  cidr       = "10.54.81.0/24"
  ip_version = 4
}
