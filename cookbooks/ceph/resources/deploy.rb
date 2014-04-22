actions :install, :new, :mon, :gatherkeys
default_action :install
attribute :name, :kind_of => String, :name_attribute => true
attribute :nodes, :kind_of => Array, :default => ["localhost"]
attribute :dev, :kind_of => String, :default => ""
attribute :host_zero, :kind_of => String, :default => "localhost"
attribute :monitor, :kind_of => String, :default => "localhost"
