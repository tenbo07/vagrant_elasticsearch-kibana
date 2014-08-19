# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def setup_chef_solo(config, &block)
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.cookbooks_path = ['./cookbooks', './site-cookbooks']
    yield(chef) if block_given?
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :elasticsearch do |es|
    es.vm.box = "hashicorp/precise64"
    es.vm.network "private_network", ip: "192.168.33.10"
    es.vm.hostname = 'elasticsearch'

    es.vm.provider :virtualbox do |vb|
      vb.name = "elasticsearch"
      vb.memory = 2048
      vb.cpus = 2
    end

    es.omnibus.chef_version = :latest
      setup_chef_solo(es) do |chef|
        chef.add_recipe 'recipe[elasticsearch::default]'
        chef.json = {
          "java" => {
            "install_flavor" => "oracle",
            "jdk_version" => "7",
            "oracle" => {
              "accept_oracle_download_terms" => true
            }
          }
        }
    end
  end

  config.vm.define :simple_node do |sn|
    sn.vm.box = "chef/ubuntu-12.04"
    sn.vm.network "private_network", ip: "192.168.33.20"
    sn.vm.hostname = 'apacheserver'

    sn.vm.provision "shell", inline: "apt-get update"
    sn.omnibus.chef_version = :latest
    setup_chef_solo(sn) do |chef|
      chef.add_recipe "recipe[yum]"
      chef.add_recipe "recipe[apt]"
      chef.add_recipe "recipe[es-td-agent::default]"
      chef.add_recipe "recipe[apache::default]"
      chef.json = {
      }
    end
  end
end
