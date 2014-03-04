#!/bin/bash

sudo apt-get install -y git
wget -O /tmp/chef_11.10.4-1.ubuntu.12.04_amd64.deb 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef_11.10.4-1.ubuntu.12.04_amd64.deb'
sudo dpkg -i /tmp/chef_11.10.4-1.ubuntu.12.04_amd64.deb
sudo mkdir /etc/chef /var/chef-solo
cat <<'EOF' > /tmp/solo.rb
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
EOF
sudo mv /tmp/solo.rb /etc/chef/solo.rb
git clone https://github.com/mmgaggle/ceph-solo.git /tmp/ceph-solo.git
sudo ln -s /tmp/ceph-solo.git/cookbooks /var/chef-solo/cookbooks
sudo chef-solo -o 'recipe[ceph]'
