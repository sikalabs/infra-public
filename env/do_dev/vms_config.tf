locals {
  vm_templates = {
    example = merge(local.default_do_vm, {
      droplet_name = "example"
      record_name  = "example"
      size         = "s-1vcpu-2gb"
    })
    crc = merge(local.default_do_vm, {
      droplet_name = "crc"
      record_name  = "crc"
      image        = local.IMAGE.CENTOS
      size         = "s-8vcpu-16gb"
    })
    nfs = merge(local.default_do_vm, {
      droplet_name = "nfs"
      record_name  = "nfs"
      user_data    = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    apt-get update
    apt-get install -y nfs-kernel-server
    mkdir /nfs
    echo '/nfs *(rw,no_root_squash)' > /etc/exports
    systemctl restart nfs-kernel-server
EOF
    })
  }
  vms = {
    nfs = local.vm_templates.nfs
  }
}
