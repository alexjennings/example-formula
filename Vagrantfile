Vagrant.configure("2") do |config|
# Centos 6.5
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"
  config.vm.box = "centos-65-x64-virtualbox-nocm.box"
# Uncomment for Ubuntu 12.04
#  config.vm.box = "precise64.box"
#  config.vm.box_url = "http://files.vagrantup.com/precise64.box"


  config.vm.network :public_network

  config.vm.synced_folder ".", "/srv/salt/"
  config.vm.provider :virtualbox do |vb|
  end


  config.vm.define :vagrantexample do |vagrantexample|
    vagrantexample.vm.hostname = "vagrant-example"
  end

  config.vm.provision :salt do |salt|
    salt.run_highstate = true
    salt.minion_config = "minion"
    salt.verbose = true
  end

end
