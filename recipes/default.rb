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
  code "git clone https://github.com/sstephenson/rbenv.git /home/deploy/.rbenv"
  creates "/home/deploy/.rbenv"
end

bash "export $PATH" do
  code "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> /home/deploy/.zshrc"
  not_if "grep 'rbenv/bin' /home/deploy/.zshrc"
end

bash "export initialize eval code" do
  code "echo 'eval \"$(rbenv init -)\"' >> /home/deploy/.zshrc"
  not_if "grep 'rbenv init' /home/deploy/.zshrc"
end

bash "source .zshrc" do
  code "source /home/deploy/.zshrc"
end

bash "grab ruby_build code" do
  user "deploy"
  code "git clone https://github.com/sstephenson/ruby-build.git /home/deploy/.rbenv/plugins/ruby-build"
  creates "/home/deploy/.rbenv/plugins/ruby-build"
end

bash "install ruby 2.0.0-247" do
  user "deploy"
  code "source /home/deploy/.zshrc && rbenv install 2.0.0-p247 && rbenv rehash"
  creates "/home/deploy/.rbenv/versions/2.0.0-p247"
  environment ({'HOME' => '/home/deploy'})
end

bash "set default ruby version" do
  user "deploy"
  code "echo '2.0.0-p247' > /home/deploy/.ruby-version"
  environment ({'HOME' => '/home/deploy'})
  not_if "grep '247' /home/deploy/.ruby-version"
end
