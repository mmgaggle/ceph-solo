include_recipe "apt"

apt_repository "ceph" do
  uri "http://ceph.com/debian-dumpling/" do
  distribution "precise"
  components ["main"]
  key "https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc"
end

package "ceph-deploy" do
  action :install
end
