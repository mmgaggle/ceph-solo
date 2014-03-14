include_recipe "apt"
include_recipe "mdadm"

execute "parted" do
  command "grep 3907018584 /proc/partitions|awk '{print $4}'|xargs -n1 -I '{}' sudo parted /dev/'{}' -s -a optimal mklabel gpt -- mkpart primary fat32 1 -1"
  # notif mdadm status or something..
end

execute "mdadm create" do
  command "grep 3907018584 /proc/partitions|awk '{print \"/dev/\"$4\"1\"}' | xargs sudo mdadm --create --metadata 1.0 --verbose /dev/md0 --chunk=512 --level=6 --raid-devices=$(grep 3907018584 /proc/partitions|awk '{print $4}'|wc -l)"
  not_if "mdadm --detail /dev/md0"
end
