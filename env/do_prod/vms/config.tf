locals {
  SSH_KEYS = [
    data.digitalocean_ssh_key.ondrejsika.id,
  ]
  IMAGE = {
    DOCKER = "docker-20-04"
    DEBIAN = "debian-11-x64"
    CENTOS = "centos-7-x64"
  }
  SIZE = {
    SMALL = "s-1vcpu-1gb"
  }
  ZONE_ID = {
    SL_ZONE = "9afcac4eb68de7f157f1c126d874cd1a"
  }
  USER_DATA = {
    DEFAULT = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
EOF
  }
}
