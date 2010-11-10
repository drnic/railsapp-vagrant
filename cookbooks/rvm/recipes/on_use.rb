require_recipe "rvm"

username = node[:vagrant][:config][:ssh][:username]

file "/home/#{username}/.rvmrc" do
  mode "644"
  content <<-FILE.gsub(/^  /, '')
  rvm_install_on_use_flag=1
  rvm_project_rvmrc=1
  rvm_gemset_create_on_use_flag=1
  FILE
  action :create_if_missing
end
