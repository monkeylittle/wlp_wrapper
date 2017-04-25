
actions :create, :destroy

default_action :create if defined?(default_action)

attribute :base_name, :name_attribute => true, :kind_of => String, :required => true

attribute :auto_start, :kind_of => [ TrueClass, FalseClass ], :required => false, :default => true
attribute :context_root, :kind_of => String, :required => true
attribute :type, :kind_of => String, :required => false, :default => 'war'


attribute :server_name, :kind_of => String, :required => true

attribute :resource, :kind_of => String, :required => true
attribute :resource_checksum, :kind_of => String, :required => false
attribute :resource_provider, :kind_of => String, :required => false, :default => 'remote_file'
