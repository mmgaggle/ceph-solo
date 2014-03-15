include_recipe "apt"

apt_repository "cloud-archive" do
  uri "http://ubuntu-cloud.archive.canonical.com/ubuntu/"
  distribution "precise-updates/icehouse"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "5EDB1B62EC4926EA"
end

kvm_packages = %w{
  qemu-kvm
  libvirt-bin
  ubuntu-vm-builder
  bridge-utils
}

kvm_packages.each do |pkg|
  package pkg do
    action :upgrade
    options "--no-install-recommends"
  end
end

group "libvirtd" do
  action :modify
  members "ubuntu"
  append true
end

downburst_packages = %w{
  libxml2-dev
  libxslt1-dev
  python-libvirt
}

downburst_packages.each do |pkg|
  package pkg do
    options "--no-install-recommends"
    action :upgrade
  end
end

git "/tmp/downburst" do
  repository "https://github.com/ceph/downburst.git"
  revision "master"
  action :sync
end

execute "bootstrap downburst" do
  command "cd /tmp/downburst && ./bootstrap"
end
