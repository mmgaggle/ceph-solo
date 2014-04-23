fsid = %x{
    grep fsid /home/ubuntu/ceph.conf | cut -d= -f2 | awk '{print $1}'
}

node.default["ceph"]["is_radosgw"] = false
node.default["ceph"]["config"] = {
  "fsid" => fsid,
  "mon_initial_members" => "burnupi11",
  "global" => {
    "mon host" => "10.214.134.30",
    "public network" => "10.214.144.0/20",
    "cluster network" => "10.214.144.0/20",
    "auth cluster required" => "cephx",
    "auth service required" => "cephx",
    "auth client required" => "cephx",
    "filestore xattr use omap" => "true",
    "mon compact on trim" => "false~"
    "log file" => "/var/log/ceph/$name.log",
    "log to syslog" => "false",
    "log max recent" => "1",
    "debug optracker" => "20",
    "rbd cache" => "true"
  },
  "osd" => {
    "filestore merge threshold" => "40",
    "filestore split multiple" => "8",
    "osd op threads" => "8"
  },
  "mon" => {
    "max open files" => "4096",
    "mon osd down out interval" => "600",
    "osd pool default size" => "3",
    "osd pool default crush rule" => "0",
    "osd min down reports" => "11"
  },
}

include_recipe "ceph::conf"
