variable "name" {}
variable "image_id" {}
variable "key_pair_name" {}
variable "volume_size" {}
variable "volume_type" {
  default = null
}
variable "flavor_id" {}
variable "network_interfaces" {
  default = {}
}
variable "config_drive" {
  default = false
}
variable "user_data" {
  default = null
}
variable "security_groups" {
  default = ["default"]
}
variable "destination_type" {
  default = "volume"
}

resource "openstack_compute_instance_v2" "this" {
  lifecycle {
    ignore_changes = [
      image_id,
    ]
  }

  name            = var.name
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_pair_name
  security_groups = var.security_groups
  config_drive    = var.config_drive
  user_data       = var.user_data

  block_device {
    uuid                  = var.image_id
    source_type           = "image"
    boot_index            = 0
    destination_type      = var.destination_type
    delete_on_termination = true
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }

  dynamic "network" {
    for_each = var.network_interfaces
    content {
      name        = network.value.name
      fixed_ip_v4 = network.value.fixed_ip_v4
    }
  }
}

output "instance_id" {
  value = openstack_compute_instance_v2.this.id
}
