include_recipe "apt"

apt_repository "ceph-apache" do
  uri "http://gitbuilder.ceph.com/apache2-deb-precise-x86_64-basic/ref/master"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "ceph-fastcgi" do
  uri "http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-precise-x86_64-basic/ref/master"
  distribution "precise"
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

packages = %w{
  apache2
  libapache2-mod-fastcgi
}

packages.each do |pkg|
  package pkg do
    action :install
  end
end

directories = %w{
  /var/lib
  /var/lib/ceph
  /var/lib/ceph/radosgw
}

directories.each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end
end

directory "/var/lib/ceph/radosgw/ceph-radosgw.#{node['hostname']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

file "/var/lib/ceph/radosgw/ceph-radosgw.#{node['hostname']}/done" do
  owner "root"
  group "root"
  mode "0644"
  action :touch
end

service "radosgw" do
  service_name "radosgw"
  action [:disable]
end

service "radosgw-all" do
  provider Chef::Provider::Service::Upstart
  service_name "radosgw-all"
  supports :restart => true
  action [:enable, :start]
end

apache_module "fastcgi" do
  conf true
end

template "/etc/apache2/sites-available/rgw.conf" do
  source "rgw.conf.erb"
  owner "root"
  group "root"
  mode "0600"
end

apache_site "rgw.conf" do
  enable enable_setting
end
