include_recipe "apt"

apt_repository "ceph" do
  uri "http://ceph.com/debian/"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "firefly-gitbuilder" do
  uri "http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/firefly"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "ceph-extras" do
  uri "http://ceph.com/packages/ceph-extras/debian"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "ceph-apache2" do
  uri "http://gitbuilder.ceph.com/apache2-deb-precise-x86_64-basic/ref/master"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "ceph-fastcgi" do
  uri "http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-precise-x86_64-basic/ref/master"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "cloud-archive" do
  uri "http://ubuntu-cloud.archive.canonical.com/ubuntu/"
  distribution "precise-updates/grizzly"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "5EDB1B62EC4926EA"
end 

ceph_packages = %w{
  librados2
  librbd1
  ceph-common
  ceph-common-dbg
  ceph
  ceph-dbg
  python-ceph
  radosgw
  radosgw-dbg
}

ceph_packages.each do |pkg|
  package pkg do
    version "0.77-703-g3e21996-1precise"
    action :install
    options "--no-install-recommends"
  end
end

directories = %w{
  /var/run/ceph
  /var/log/ceph
  /etc/ceph
}

directories.each do |dir|
  directory dir do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end
end

kvm_packages = %w{
  qemu-kvm
  libvirt-bin
  ubuntu-vm-builder
  bridge-utils
}

kvm_packages.each do |pkg|
  package pkg do
    action :install
    options "--no-install-recommends"
  end
end

group "libvirtd" do
  action :modify
  members "ubuntu"
  append true
end

perf_packages = %w{
  collectl
  lldpd
  strace
  lsof
  iotop
  sysstat
  iperf
  fio
  git
}

perf_packages.each do |pkg|
  package pkg do
    options "--no-install-recommends"
    action :install
  end
end

apache_packages = %w{
  apache2
  apache2-mpm-worker
  apache2-utils
  apache2.2-bin
  apache2.2-common
}

apache_packages.each do |pkg|
  package pkg do
    version "2.2.22-2precise.ceph"
    options "--no-install-recommends"
    action :install 
  end
end

package "libapache2-mod-fastcgi" do
  version "2.4.7~0910052141-2~bpo70+1.ceph"
  options "--no-install-recommends"
  action :install
end

downburst_packages = %w{
  libxml2-dev
  libxslt1-dev
  python-libvirt
}

downburst_packages.each do |pkg|
  package pkg do
    options "--no-install-recommends"
    action :install
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
