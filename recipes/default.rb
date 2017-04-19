#
# Cookbook Name:: wlp_wrapper
# Recipe:: default
#
# Copyright (C) 2017 John Turner
#
# All rights reserved - Do Not Redistribute
#

# install WebSphere Application Server Liberty Profile
include_recipe 'wlp::default'

# create shared libraries
node[:wlp][:libraries].each_pair do |key, value|
  map = value.to_hash()

  wlp_wrapper_library key do
    fileset value.fileset
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
