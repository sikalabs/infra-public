locals {
  sikademo_com_zone_id = "f2c00168a7ecd694bb1ba017b332c019"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id,
  ]
}
