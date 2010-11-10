#
# Install RVM system wide
# See: http://www.agileweboperations.com/chef-rvm-ruby-enterprise-edition-as-default-ruby/
#

include_recipe "build-essential"

%w(curl git-core libreadline5-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev).each do |pkg|
  package pkg
end

bash "install RVM" do
  user "root"
  code "bash < <( curl -L http://bit.ly/rvm-install-system-wide )"
  not_if { File.exists?("/usr/local/bin/rvm") }
end 

cookbook_file "/etc/profile.d/rvm.sh" do
  mode "644"
end
