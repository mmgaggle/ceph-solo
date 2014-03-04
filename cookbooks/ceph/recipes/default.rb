include_recipe "apt"

apt_repository "ceph" do
  uri "http://ceph.com/debian/"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

apt_repository "ceph" do
  uri "http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/master"
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
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
    version "0.77-626-g1684f1d-1precise"
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
    action :install
    options "--no-install-recommends"
  end
end
