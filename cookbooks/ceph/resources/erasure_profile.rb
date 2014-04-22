 action :create, :delete
 default_action :create
 attribute :name, :kind_of => String, :name_attribute => true
 attribute :k, :kind_of => Integer
 attribute :m, :kind_of => Integer
 attribute :ruleset_failure_domain, :kind_of => String, :default => "host"
 attribute :plugin, :kind_of => String, :default => "jerasure"
 attribute :technique, :kind_of => String, :default => "reed_sol_van"
