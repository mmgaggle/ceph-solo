maintainer       "Kyle Bader"
maintainer_email "kyle.bader@dreamhost.com"
license          "Apache 2.0"
description      "Installs/Configures GlusterFS"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ apt ntp }.each do |cookbook|
  depends cookbook
end
