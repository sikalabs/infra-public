module "minio" {
  source = "../../../modules/core/do_vm"

  droplet_name = "sl-prod-minio"
  record_name  = "sl-prod-minio"
  image        = local.IMAGE.DOCKER
  region       = "fra1"
  size         = "s-1vcpu-1gb"
  user_data    = local.USER_DATA.DEFAULT
  zone_id      = local.ZONE_ID.SL_ZONE
  vpc_uuid     = null
  ssh_keys     = local.SSH_KEYS
}
