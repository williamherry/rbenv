#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "grab rbenv code" do
  user "deploy"
  code "git clone #{node[:rbenv][:git_url]} #{node[:rbenv][:install_location]}"
  creates node[:rbenv][:install_location]
end

bash "export $PATH" do
  code "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> #{node[:rbenv][:shell_file]}"
  not_if "grep 'rbenv/bin' #{node[:rbenv][:shell_file]}"
end

bash "export initialize eval code" do
  code "echo 'eval \"$(rbenv init -)\"' >> #{node[:rbenv][:shell_file]}"
  not_if "grep 'rbenv init' #{node[:rbenv][:shell_file]}"
end

bash "source .zshrc" do
  code "source #{node[:rbenv][:shell_file]}"
end

bash "grab ruby_build code" do
  user "deploy"
  code "git clone https://github.com/sstephenson/ruby-build.git #{node[:ruby_build][:install_location]}"
  creates node[:ruby_build][:install_location]
end

bash "install ruby #{node[:rbenv][:ruby_version]}" do
  user "deploy"
  code "source #{node[:rbenv][:shell_file]} && rbenv install #{node[:rbenv][:ruby_version]} && rbenv rehash"
  creates "#{node[:rbenv][:install_location]}/versions/#{node[:rbenv][:ruby_version]}"
  environment ({'HOME' => node[:rbenv][:user_home]})
end

bash "set default ruby version" do
  user "deploy"
  code "echo #{node[:rbenv][:ruby_version]} > #{node[:rbenv][:user_home]}/.ruby-version"
  environment ({'HOME' => node[:rbenv][:user_home]})
  not_if "grep #{node[:rbenv][:ruby_version]} #{node[:rbenv][:user_home]}/.ruby-version"
end
