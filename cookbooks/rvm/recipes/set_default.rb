#
# Set the default ruby in RVM
#
require_recipe "rvm"

default_ruby = node.rvm[:default_ruby]

bash "set the default ruby" do
  user "root"
  code "rvm --default #{default_ruby}"
end
