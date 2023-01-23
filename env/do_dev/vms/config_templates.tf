
locals {
  template_default = {
    image     = local.IMAGE.DEBIAN
    region    = "fra1"
    size      = "s-1vcpu-1gb"
    user_data = local.default_user_data
    zone_id   = local.sikademo_com_zone_id
    ssh_keys  = local.ssh_keys
    vpc_uuid  = null
  }
  template_nfs = merge(local.template_default, {
    user_data = local.nfs_user_data
  })
  template_lab = merge(local.template_default, {
    image        = local.IMAGE.DOCKER
    size         = "s-2vcpu-4gb"
    droplet_name = "lab"
    record_name  = "lab"
    user_data    = local.lab_user_data
  })
  default_user_data = <<EOF
#cloud-config
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt-get update
    apt-get install -y curl sudo git mc htop vim tree
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
EOF
  nfs_user_data     = <<EOF
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
    echo '/nfs *(rw,no_root_squash,insecure)' > /etc/exports
    systemctl restart nfs-kernel-server
EOF
  lab_user_data     = <<EOF
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
write_files:
- path: /root/.zshrc.default
  permissions: "0755"
  owner: root:root
  content: |
    export ZSH="$HOME/.oh-my-zsh"
    plugins=(git kube-ps1)
    ZSH_THEME=alanpeabody
    source $ZSH/oh-my-zsh.sh
- path: /root/.config/code-server/config.yaml
  permissions: "0755"
  owner: root:root
  content: |
    auth: password
    password: asdfasdf2020
    cert: false
- path: /root/.local/share/code-server/User/settings.json
  permissions: "0755"
  owner: root:root
  content: |
    {
      "terminal.integrated.shell.linux": "/bin/zsh"
    }
runcmd:
  - |
    rm -rf /etc/update-motd.d/99-one-click
    apt update
    apt install -y curl sudo git mc redis-tools htop vim tree zsh
    systemctl stop ufw
    systemctl disable ufw
    curl -fsSL https://raw.githubusercontent.com/sikalabs/slu/master/install.sh | sudo sh
    slu install-bin training-cli -v v0.5.0-dev-7
    HOME=/root training-cli kubernetes vm-setup
    curl -fsSL https://code-server.dev/install.sh | HOME=/root sh
    systemctl enable --now code-server@root
    docker run -d --name proxy-8080 --net host sikalabs/slu:v0.50.0 slu proxy tcp -l :80 -r 127.0.0.1:8080
    # Docker
    slu install-bin crane
    slu install-bin reg
    # Terraform
    slu install-bin terraform
    slu install-bin kubectl
    slu install-bin helm
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp /root/.zshrc.default /root/.zshrc
    echo "alias k=kubectl" >> /root/.zshrc
    echo "alias kx=kubectx" >> /root/.zshrc
    echo "alias kn=kubens" >> /root/.zshrc
    echo "source <(kubectl completion zsh)" >> /root/.zshrc
    echo "source <(helm completion zsh)" >> /root/.zshrc
    echo "source <(slu completion zsh)" >> /root/.zshrc
    echo 'alias w="watch -n 0.3 "' >> /root/.zshrc
    echo ". <(slu completion zsh); compdef _slu slu" >> /root/.zshrc
    echo ". <(training-cli completion zsh); compdef _training-cli training-cli" >> /root/.zshrc
    chsh -s /bin/zsh
    slu install-bin filebeat
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
    sudo apt-get install -y apt-transport-https
    echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
    sudo apt-get update
EOF
}
