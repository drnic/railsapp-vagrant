Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.provisioner = :chef_solo
  config.chef.cookbooks_path = "cookbooks"
  %w[apt openssl git ruby rubygems rails mysql mysql::server java rvm].each {|r|
    config.chef.add_recipe r
  }

  config.chef.json.merge!({ :mysql => { :server_root_password => "" } })
end
