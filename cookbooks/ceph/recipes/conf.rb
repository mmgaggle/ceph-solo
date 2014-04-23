directory "/etc/ceph" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/ceph/ceph.conf" do
  source "ceph.conf.erb"
  variables(
    :is_rgw
  )
  mode "0644"
end
