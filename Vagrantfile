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
  config.vm.box = "hashicorp/precise64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = 'elasticsearch'

  config.vm.provider :virtualbox do |vb|
    vb.name = "elasticsearch"
    vb.memory = 2048
    vb.cpus = 2
  end

  config.omnibus.chef_version = :latest
    setup_chef_solo(config) do |chef|
      chef.add_recipe 'recipe[java]'
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
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end

end
