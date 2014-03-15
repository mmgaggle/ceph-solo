execute "create libvirt-pool volume" do
  command "(sudo gluster peer status && echo \"Hostname: $(hostname -f)\") | grep -i hostname | cut -d: -f2 | xargs -n1 -I '{}' echo -n \"{}:/mnt/gluster/bricks/bricksv1 \""
  not_if "gluster volume info libvirt-pool"
end

execute "start gluster volume" do
  command "gluster volume start livbirt-pool" do
  not_if "gluster volume info libvirt-pool"
end
