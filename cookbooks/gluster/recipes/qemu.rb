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
