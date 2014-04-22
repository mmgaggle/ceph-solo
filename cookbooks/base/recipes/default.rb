include_recipe "chef-sugar::default"

if ubuntu?
  include_recipe "apt"
  package "lldpd" do
    action :upgrade
  end
elsif centos?
  remote_file "/tmp/epel-release-6-8.noarch.rpm" do
    source "http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm"
  end
  rpm_package "epel" do
    source "/tmp/epel-release-6-8.noarch.rpm"
    action :install
  end
  package "lldpad" do
    action :upgrade
  end
end

packages = %w{
  collectl
  strace
  lsof
  iotop
  sysstat
  iperf
  fio
  git
  screen
}

packages.each do |pkg|
  package pkg do
    if ubuntu?
      options "--no-install-recommends"
    end
    action :upgrade
  end
end
