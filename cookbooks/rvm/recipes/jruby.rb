#
# Installs jruby via rvm.
#

require_recipe "rvm"
require_recipe "java::default"

bash "Install jruby in rvm" do
  user "root"
  code "rvm install jruby"
  not_if "rvm list | grep jruby"
end
