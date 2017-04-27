
use_inline_resources

action :create do

  server_dir = @utils.serverDirectory(new_resource.server_name)
  server_app_dir = "#{server_dir}/apps"

  # create server app directory
  directory server_app_dir do
    owner node['wlp']['user']
    group node['wlp']['group']
    recursive true
  end

  # source application resource
  case new_resource.resource_provider
  when 'remote_file'
    location = "#{server_app_dir}/#{new_resource.base_name}.#{new_resource.type}"

    remote_file location do
      source new_resource.resource
      checksum new_resource.resource_checksum
      owner node['wlp']['user']
      group node['wlp']['group']
      action :create_if_missing
    end
  end

  # create application config
  template "#{server_dir}/#{new_resource.base_name}.application.xml" do
    source 'application.erb'
    owner node['wlp']['user']
    group node['wlp']['group']
    variables({
      auto_start: new_resource.auto_start,
      context_root: new_resource.context_root,
      location: location,
      name: new_resource.base_name,
      type: new_resource.type
    })
  end

end

action :destroy do

end

def load_current_resource
  @utils = Liberty::Utils.new(node)
end
