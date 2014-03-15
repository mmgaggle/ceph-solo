directory "/mnt/gluster" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

directory "/mnt/gluster/bricks" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

mount "/mnt/gluster/bricks" do
  device "/dev/md0"
  options "inode64,noatime,logbsize=256k"
  fstype "xfs"
end

directory "/mnt/gluster/bricks/bricksv1" do
  owner "root"
  group "root"
  mode 00644
  action :create
end
