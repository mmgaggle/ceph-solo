file "/etc/sysctl.d/10-ceph-cache.conf" do
  owner "root"
  group "root"
  mode 0644
  content "vm.vfs_cache_pressure = 10"
  action :create
end

execute "Set VFS cache pressure to 10" do
  command "sysctl -p /etc/sysctl.d/10-ceph-cache.conf"
end
