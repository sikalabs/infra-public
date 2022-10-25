locals {
  default_user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf2020
chpasswd:
  expire: false
write_files:
- path: /usr/local/bin/k
  permissions: "0755"
  owner: root:root
  content: |
    #!/bin/sh
    kubectl $@
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt update
    apt install -y curl sudo git mc redis-tools htop vim tree
    systemctl stop ufw
    systemctl disable ufw
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    slu install-bin training-cli -v v0.4.2
    HOME=/root training-cli kubernetes vm-setup
EOF
  vm_templates = {
    lab = merge(var.default_do_vm, {
      image        = "docker-20-04"
      size         = "s-2vcpu-4gb"
      droplet_name = "lab-k8s-"
      record_name  = "lab"
      user_data    = local.default_user_data
    })
  }
}
