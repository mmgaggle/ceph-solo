include_recipe "apt"

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
    options "--no-install-recommends"
    action :upgrade
  end
end
