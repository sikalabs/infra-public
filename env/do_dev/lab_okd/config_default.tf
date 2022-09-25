locals {
  default_user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf1234
chpasswd:
  expire: false
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
EOF
  vm_templates = {
    lab = merge(var.default_do_vm, {
      droplet_name = "lab-okd"
      record_name  = "lab"
    })
  }
}
