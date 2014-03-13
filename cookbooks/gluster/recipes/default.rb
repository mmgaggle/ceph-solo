include_recipe "apt"

apt_repository "glusterfs" do
  uri "http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.4/ubuntu"
  distribution "precise"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "774BAC4D"
end

packages = %w{
  glusterfs-common
  glusterfs-dbg
  glusterfs-client
  glusterfs-server
}

packages.each |pkg| do
  package pkg do
    action :install
    version "3.4.2-ubuntu2~precise6"
  end
end
