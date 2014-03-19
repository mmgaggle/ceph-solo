#!/bin/bash

sudo yum install -y git
curl -o /tmp/chef-11.10.4-1.el6.x86_64.rpm https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-11.10.4-1.el6.x86_64.rpm
sudo rpm -i /tmp/chef-11.10.4-1.el6.x86_64.rpm
sudo mkdir /etc/chef /var/chef-solo
cat <<"EOF" > /tmp/solo.rb
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
EOF
sudo mv /tmp/solo.rb /etc/chef/solo.rb
git clone https://github.com/mmgaggle/cbtcfg.git /tmp/cbtcfg.git
sudo ln -s /tmp/cbtcfg.git/cookbooks /var/chef-solo/cookbooks
sudo chef-solo -o "recipe[tools]"
