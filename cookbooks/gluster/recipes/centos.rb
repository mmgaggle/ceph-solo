include_recipe "apt"

yum_repository 'gluster' do
  description 'Gluster "I don\'t wanna bother with GPG" package repo'
  baseurl "http://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/glusterfs-epel.repo"
  action :create
end


gluster_packages = %w{
  glusterfs
  glusterfs-fuse
  glusterfs-server
}

gluster_packages.each do |pkg|
  package pkg do
    action :install
  end
end
