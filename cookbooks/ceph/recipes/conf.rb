fail "fsid must be set in config" if node['ceph']['fsid'].nil?
fail "mon_initial_members must be set in config" if node['ceph']['config']['mon_initial_members']

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
