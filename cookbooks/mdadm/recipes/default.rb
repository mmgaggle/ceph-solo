include_recipe "apt"

packages = %w{
  mdadm
  parted
}

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
