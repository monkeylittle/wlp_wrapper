#
# Cookbook Name:: wlp_wrapper
# Recipe:: default
#
# Copyright (C) 2017 John Turner
#
# All rights reserved - Do Not Redistribute
#

liberty_utils = Liberty::Utils.new(node)

# install liberty profile
include_recipe 'wlp::default'

# create shared libraries
node[:wlp][:libraries].each_pair do |library_name, library_defn|
  wlp_wrapper_library library_name do
    fileset library_defn.fileset
  end
end

# create applications
node[:wlp][:applications].each_pair do |application_name, application_defn|
  wlp_wrapper_application application_name do
    context_root application_defn.context_root

    resource application_defn.resource
    resource_checksum application_defn.resource_checksum
    resource_provider application_defn.resource_provider

    server_name application_defn.server_name
  end
end

# create liberty profile server instances
include_recipe 'wlp::serverconfig'

# start each server instance
node[:wlp][:servers].each_pair do |key, value|
  map = value.to_hash()
  enabled = map.delete("enabled")
  if enabled.nil? || enabled == true || enabled == "true"
    serverName = map.delete("serverName") || key

    wlp_server serverName do
      clean true
      action :start
    end
  end
end
