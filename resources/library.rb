
actions :create, :destroy

default_action :create if defined?(default_action)

attribute :base_name, :name_attribute => true, :kind_of => String, :required => false, :default => 'default'

attribute :fileset, :kind_of => Array, :required => true
