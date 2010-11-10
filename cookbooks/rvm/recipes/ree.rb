#
# Installs ree using rvm.
#

require_recipe "rvm"

bash "Install ree in rvm" do
  user "root"
  code "rvm install ree"
  not_if "rvm list | grep ree"
end
