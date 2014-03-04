#!/bin/bash

wget -O /tmp/chef_11.10.4-1.ubuntu.12.04_amd64.deb 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef_11.10.4-1.ubuntu.12.04_amd64.deb'
sudo dpkg -i /tmp/chef_11.10.4-1.ubuntu.12.04_amd64.deb
sudo mkdir /etc/chef /var/chef-solo
sudo echo <<EOF >> /etc/chef/solo.rb
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
EOF
