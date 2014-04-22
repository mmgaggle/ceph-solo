maintainer       "Kyle Bader"
maintainer_email "kyle@inktank.com"
license          "Apache 2.0"
description      "Configuration for Ceph Storage Systems"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ apache2 apt ntp }.each do |cookbook|
  depends cookbook
end
