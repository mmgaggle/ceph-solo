 actions :create, :delete
 default_action :create
 attribute :name, :kind_of => String, :name_attribute => true
 attribute :force, :equal_to => [true, false], :default => false
 attribute :pg_num, :kind_of => Integer, :default => 128
 attribute :pgp_num, :kind_of => Integer, :default => 128
 attribute :erasure, :kind_of => String, :default => ""
 attribute :erasure_code_profile, :kind_of => String, :default => ""
