include_recipe "apt"

apt_repository "glusterfs" do
  uri "http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.4/ubuntu"
  distribution "precise"
  components ["main"]
  key "http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.4/ubuntu/dists/precise/Release.gpg"
end

packages = %w{
  glusterfs-common
  glusterfs-dbg
  glusterfs-client
  glusterfs-server
}

package "glusterfs-client" do
  action :install
end
