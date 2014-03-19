include_recipe "chef-sugar::default"

if ubuntu?
  include_recipe "apt"
elsif centos?
  include_recipe "yum::default"
  remote_file "/tmp/epel-release-6-8.noarch.rpm" do
    source "http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm"
  end
  rpm_package "epel" do
    source "/tmp/epel-release-6-8.noarch.rpm"
    action :install
  end
end

packages = %w{
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

packages.each do |pkg|
  package pkg do
    if ubuntu?
      options "--no-install-recommends"
    end
    action :upgrade
  end
end
