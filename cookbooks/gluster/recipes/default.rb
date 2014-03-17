include_recipe "apt"

apt_repository "glusterfs" do
  uri "http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.4/ubuntu"
  distribution "precise"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "774BAC4D"
end

apt_repository "glusterfs-qemu" do
  uri "http://ppa.launchpad.net/semiosis/ubuntu-qemu-glusterfs/ubuntu"
  distribution "saucy"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "774BAC4D"
end

gluster_packages = %w{
  glusterfs-common
  glusterfs-dbg
  glusterfs-client
  glusterfs-server
}

gluster_packages.each do |pkg|
  package pkg do
    action :install
    version "3.4.2-ubuntu2~precise6"
  end
end
