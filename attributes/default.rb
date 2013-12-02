default[:rbenv][:git_url] = "https://github.com/sstephenson/rbenv.git"
default[:rbenv][:ruby_version] = "2.0.0-p247"
default[:rbenv][:user] = "deploy"
default[:rbenv][:user_shell] = "zsh"

default[:rbenv][:user_home] = "/home/#{node[:rbenv][:user]}"
default[:rbenv][:install_location] = "#{node[:rbenv][:user_home]}/.rbenv"
default[:rbenv][:shell_file] = "#{node[:rbenv][:user_home]}/.#{node[:rbenv][:user_shell]}rc"
default[:ruby_build][:install_location] = "#{node[:rbenv][:install_location]}/plugins/ruby-build"
