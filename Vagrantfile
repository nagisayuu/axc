# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# ネットワーク設定については以下を参照
# http://qiita.com/ftakao2007/items/0ec05c2ef3c14cdbea11

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
$common_setting = <<-EOT
  ### timezone
    cp -p /usr/share/zoneinfo/Japan /etc/localtime
  ### iptables off
    /sbin/iptables -F
    /sbin/service iptables stop
    /sbin/chkconfig iptables off
  ### apt-get update
    sudo apt-get -y update
EOT

$nodeJS = <<-EOT
  ### apt-get update
    sudo apt-get -y update
  ### git
    sudo apt-get -y install git
  ### nvm
    sudo -u vagrant -i git clone git://github.com/creationix/nvm.git ~vagrant/.nvm
    sudo -u vagrant -i echo "if [[ -s ~vagrant/.nvm/nvm.sh ]] ; then source ~vagrant/.nvm/nvm.sh ; fi" >> ~vagrant/.bash_profile
    sudo -u vagrant -i source ~vagrant/.bash_profile
  ### nodeJS and npm
    sudo -u vagrant -i nvm install --lts
    sudo -u vagrant -i nvm use --lts
  ###  (*optional) AngularJS
    sudo -u vagrant -i npm install -g @angular/cli
EOT

$geth = <<-EOT
  ### apt-get update
    sudo apt-get -y update
  ### Go and C Compiler
    sudo apt-get install -y build-essential libgmp3-dev golang git tree
  ### clone geth v1.5.5
    sudo -u vagrant -i git clone git://github.com/ethereum/go-ethereum.git ~vagrant/go-ethereum;cd ~vagrant/go-ethereum/;git checkout refs/tags/v1.5.5
  ### setup geth
    sudo -u vagrant -i cd ~vagrant/go-ethereum/;make geth
  ### setup geth
    sudo cp ~vagrant/go-ethereum/build/bin/geth /usr/local/bin/
EOT

$ubuntu1_custom = <<-EOT

EOT

  # ubuntu16.04
  config.vm.box = "ubuntu16.04"
  # Vagrant管理のホスト名
  config.vm.define :ubuntu1 do |node|
    # ubuntu16.04
    node.vm.box = "ubuntu16.04"
    # IP address
    node.vm.network :private_network, ip:"192.168.33.10"
    node.vm.network :forwarded_port, guest:4200, host:80, id:"http"
    # settings
    node.vm.provision :shell, :inline => $common_setting
    node.vm.provision :shell, :inline => $nodeJS
    node.vm.provision :shell, :inline => $geth
    # synced_folder
    config.vm.synced_folder "./ubuntu", "/vagrant_data",type: "rsync", rsync_auto: true
  end

end
