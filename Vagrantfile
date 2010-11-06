Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.provisioner = :chef_solo
  config.chef.cookbooks_path = "cookbooks"
  config.chef.add_recipe "apt"
  config.chef.add_recipe "openssl"
  config.chef.add_recipe "git"
  config.chef.add_recipe "ruby"
  config.chef.add_recipe "rubygems"
  config.chef.add_recipe "rails"
  config.chef.add_recipe "mysql"
  config.chef.add_recipe "mysql::server"
  config.chef.add_recipe "java"

  config.chef.json.merge!({ :mysql => { :server_root_password => "" } })
end
