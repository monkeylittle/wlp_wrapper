#
# Cookbook Name:: wlp_wrapper
# Recipe:: default
#
# Copyright (C) 2017 John Turner
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'wlp::default'

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
