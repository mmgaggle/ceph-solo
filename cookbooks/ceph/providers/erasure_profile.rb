use_inline_resources

def whyrun_supported?
  true
end

action :set do
  converge_by("Setting erasure profile '#{new_resource.name}'.") do
    execute "create erasure profile" do
      not_if "ceph osd erasure-code-profile ls | grep -q '^#{new_resource.name}$'"
      command("ceph osd erasure-code-profile set #{new_resource.name} \
                 ruleset-failure-domain=#{new_resource.ruleset_failure_domain} \
                 k=#{new_resource.k} \
                 m=#{new_resource.m} \
                 plugin=#{new_resource.plugin} \
                 technique=#{new_resource.technique}")
    end
    Chef::Log.info("Erasure profile '#{new_resource.name}' set.")
  end
end

action :rm do
  converge_by("Deleting erasure profile '#{new_resource.name}'") do
    execute "delete erasure profile" do
      only_if "ceph erasure-code-profile ls | grep -q '^#{new_resource.name}$'"
      if new_resource.force == true
        command("ceph osd erasure-code-profile rm #{new_resource.name}")
      end
      Chef::Log.info("Deleted erasure profile '#{new_resource.name}'")
    end
  end
end
