#
# Cookbook Name:: wlp_wrapper
# Recipe:: default
#
# Copyright (C) 2017 John Turner
#
# All rights reserved - Do Not Redistribute
#

# install WebSphere Application Server Liberty Profile

liberty_utils = Liberty::Utils.new(node)

include_recipe 'wlp::default'

# create shared libraries
node[:wlp][:libraries].each_pair do |key, value|
  map = value.to_hash()

  wlp_wrapper_library key do
    fileset value.fileset
  end
end

# source application remote files
node[:wlp][:servers].each_pair do |key, value|
  server_name = key
  server_config = value.to_hash()

  server_dir = liberty_utils.serverDirectory(server_name)

  app_dir = "#{server_dir}/apps"

  directory app_dir do
    owner node['wlp']['user']
    group node['wlp']['group']
    recursive true
  end

  server_config['application'].each_with_index do |application, application_index|
    app_name = application['name']
    app_type = application['type']

    remote_file "#{app_dir}/#{app_name}.#{app_type}" do
      source application['remote_file']
      checksum application['checksum']
      owner node['wlp']['user']
      group node['wlp']['group']
      action :create_if_missing
    end

    node.rm('wlp', 'servers', server_name, 'application', application_index, 'remote_file')

    node.normal[:wlp][:servers][server_name][:application][application_index][:location] = "#{app_name}.#{app_type}"
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
