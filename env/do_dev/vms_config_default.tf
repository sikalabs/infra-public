locals {
  IMAGE = {
    DOCKER = "docker-20-04"
    DEBIAN = "debian-10-x64"
    CENTOS = "centos-7-x64"
  }
}

locals {
  default_user_data = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
EOF
  default_do_vm = {
    image     = local.IMAGE.DEBIAN
    region    = "fra1"
    size      = "s-1vcpu-1gb"
    user_data = local.default_user_data
    zone_id   = local.sikademo_com_zone_id
    ssh_keys  = local.ssh_keys
    vpc_uuid  = null
  }
}
