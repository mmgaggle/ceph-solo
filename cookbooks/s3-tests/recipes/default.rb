include_recipe "git"
include_recipe "ceph"

package "python-virtualenv" do
  action :install
end

git "/tmp/s3-tests" do
  repository "https://github.com/ceph/s3-tests.git"
  revision "master"
  action :sync
end

execute "bootstrap s3-tests" do
  command "cd /tmp/s3-tests && ./bootstrap"
end

# generate random user prefix

#rgw_user "primary" do
#  uid "primary"
#  email "primary@example.com"
#end

#rgw_user "secondary" do
#  uid "secondary"
#  email "secondary@example.com"
#end

#template "/tmp/s3-tests/s3-tests.conf" do
#  owner "root"
#  group "root"
#  mode "0644"
#end
