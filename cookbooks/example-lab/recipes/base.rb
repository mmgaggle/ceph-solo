include_recipe "ceph::deploy"

ceph_deploy "install" do
  dev "--dev"
  nodes ["burnupi11","burnupi14","burnupi15","burnpui47","rhoda001","rhoda002","rhoda003","rhoda004"]
  action :install
end

ceph_deploy "new" do
  host_zero "burnupi11"
  action :new
end

ceph_deploy "mon" do
  monitor "burnupi11"
  action :mon
end

ceph_deploy "gatherkeys" do
  monitor "burnupi11"
  action :gatherkeys
end
