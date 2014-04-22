use_inline_resources

def whyrun_supported?
  true
end

action :create do
  converge_by("Creating pool '#{new_resource.name}'") do
    execute "create pool" do
      not_if "ceph osd lspools | grep -qE '\d*? #{new_resource.name},'"
      command("ceph osd pool create #{new_resource.name} \
                #{new_resource.pg_num} \
                #{new_resource.pgp_num} \
                #{new_resource.erasure} \
                #{new_resource.erasure_code_profile}")
    end
    Chef::Log.info("Create pool '#{new_resource.name}'")
  end
end

action :delete do
  converge_by("Deleting pool '#{new_resource.name}'") do
    execute "delete pool" do
      only_if "ceph osd lspools | grep -qE '\d*? #{new_resource.name},'"
      if new_resource.force == true
        command("ceph osd pool delete #{new_resource.name} #{new_resource.name} --yes-i-really-really-mean-it")
      end
      Chef::Log.info("Deleted pool '#{new_resource.name}'")
    end
  end
end
