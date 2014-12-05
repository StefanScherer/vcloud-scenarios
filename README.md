# Vagrant vCloud scenarios
Each sub directory contains a small multi machine scenario to use with the vagrant-vcloud plugin.

At the moment you need already uploaded baseboxes in your vCloud catalog with the following names. You
also can use a global vCloud catalog with such boxes.

* ubuntu1204
* windows_2008_r2

Create dummy boxes for Vagrant by downloading the dummy.box file prepared for the vcloud provider.

```
vagrant box add ubuntu1204 https://github.com/StefanScherer/vcloud-scenarios/raw/master/dummy_box/dummy.box
vagrant box add windows_2008_r2 https://github.com/StefanScherer/vcloud-scenarios/raw/master/dummy_box/dummy.box
```

## Global Vagrantfile
You also need a global Vagrantfile with your credentials to connect to your vCloud organziation.
Put this in your home directory in `~/.vagrant.d/Vagrantfile` and Vagrant uses this in combination with any project Vagrantfile.

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-vcloud")
    # vCloud Director provider settings
    config.vm.provider :vcloud do |vcloud|
      vcloud.hostname = "https://YOUR-VCLOUD-SERVER"
      vcloud.username = "vagrant"
      vcloud.password = "YOUR-SECRET-PASSWORD"

      vcloud.org_name = "YOUR-ORG"
      vcloud.vdc_name = "YOUR-VDC"

      vcloud.catalog_name = "Vagrant"

      vcloud.vdc_network_name = "YOUR-INTERNAL-NET"

      # vcloud.vdc_edge_gateway = "YOUR-EDGE"
      # vcloud.vdc_edge_gateway_ip = "10.100.52.4"
    end
  end

end
```
