use_inline_resources

def whyrun_supported?
  true
end

action :install do
  converge_by("Install ceph on '#{new_resource.name}'") do
    execute "ceph deploy install" do
      command("ceph-deploy --username ubuntu install #{new_resource.dev} #{new_resource.nodes.join(' ')}")
      user "ubuntu"
      cwd "/home/ubuntu"
      environment({"LOGNAME" => "ubuntu"})
    end
    Chef::Log.info("Ceph installed on #{new_resource.nodes}")
  end
end

action :new do
  converge_by("Create new cluster, host zero: '#{new_resource.host_zero}'") do
    execute "ceph deploy new" do
      command("ceph-deploy new #{new_resource.host_zero}")
      user "ubuntu"
      cwd "/home/ubuntu"
      environment({"LOGNAME" => "ubuntu"})
    end
    Chef::Log.info("Ceph cluster created, host zero: '#{new_resource.host_zero}'")
  end
end 

action :mon do
  converge_by("Create new monitor on '#{new_resource.monitor}'") do
    execute "ceph deploy mon create" do
      command("ceph-deploy mon create #{new_resource.monitor}")
      user "ubuntu"
      cwd "/home/ubuntu"
      environment({"LOGNAME" => "ubuntu"})
    end
    Chef::Log.info("Ceph monitor created on '#{new_resource.monitor}'")
  end
end

action :gatherkeys do
  converge_by("Gathering keys from '#{new_resource.monitor}'") do
    execute "ceph deploy gatherkeys" do
      command("ceph-deploy gatherkeys #{new_resource.monitor}")
      user "ubuntu"
      cwd "/home/ubuntu"
      environment({"LOGNAME" => "ubuntu"})
    end
    Chef::Log.info("CephX keys gathered")
  end
end

# disk zap
# osd prepare
# osd activate
