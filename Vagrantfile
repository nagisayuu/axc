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
  ### initialize .bash_profile
    sudo -u vagrant -i touch ~vagrant/.bash_profile
    sudo -u vagrant -i chown vagrant:vagrant ~vagrant/.bash_profile
    sudo -u vagrant -i echo "test -r ~/.bashrc && . ~/.bashrc"  >> ~vagrant/.bash_profile
    sudo -u vagrant -i source ~vagrant/.bash_profile
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
  ### set path
    sudo cp ~vagrant/go-ethereum/build/bin/geth /usr/local/bin/
EOT

$solidity = <<-EOT
### add ethereum repository
  sudo add-apt-repository ppa:ethereum/ethereum
### apt-get update
  sudo apt-get -y update
### install solc
  sudo apt-get -y install solc
EOT

$python = <<EOT
### apt-get update
  sudo apt-get -y update
### python libraries
  sudo apt-get install -y gcc git make libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev
### install pyenv
  sudo -u vagrant -i git clone https://github.com/pyenv/pyenv.git ~vagrant/.pyenv
### set pyenv variables
  sudo -u vagrant echo 'export PYENV_ROOT=$HOME/.pyenv' >> ~vagrant/.bash_profile
  sudo -u vagrant echo 'export export PATH=$PYENV_ROOT/bin:$PATH' >> ~vagrant/.bash_profile
  sudo -u vagrant echo 'eval "$(pyenv init -)"' >> ~vagrant/.bash_profile
  sudo -u vagrant -i source ~vagrant/.bash_profile
### install python 2.7.14
  sudo -u vagrant -i pyenv install 2.7.14;pyenv global 2.7.14
EOT


$browser_solidity = <<EOT
##### browser_solidity needs npm, python, solidity
### apt-get update
  sudo apt-get -y update
### install build-essential
  sudo apt-get install -y build-essential
### npm rebuild
  sudo -u vagrant -i npm rebuild
### clone browser_solidity
  sudo -u vagrant -i git clone https://github.com/ethereum/browser-solidity.git ~vagrant/browser_solidity
### install browser_solidity
  #sudo -u vagrant -i cd ~vagrant/browser_solidity;npm rebuild;npm install
EOT

$connect_geth_solidity = <<-EOT
  ### install genesis.json

EOT

$ubuntu1_custom = <<-EOT

EOT

  # ubuntu14.04
  config.vm.box = "ubuntu/trusty64"
  # Vagrant管理のホスト名
  config.vm.define :ubuntu1 do |node|
    # ubuntu14.04
    node.vm.box = "uubuntu/trusty64"
    # IP address
    node.vm.network :private_network, ip:"192.168.33.10"
    # browser_solidity port forwarding
    node.vm.network :forwarded_port, guest:8080, host:8080, id:"http"
    # settings
    node.vm.provision :shell, :inline => $common_setting
    node.vm.provision :shell, :inline => $nodeJS
    node.vm.provision :shell, :inline => $geth
    node.vm.provision :shell, :inline => $solidity
    node.vm.provision :shell, :inline => $python
    node.vm.provision :shell, :inline => $browser_solidity
    # synced_folder
    config.vm.synced_folder "./geth", "/home/vagrant/geth",type: "rsync", rsync_auto: true
  end

end
