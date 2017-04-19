
action :create do

  shared_config_dir = @utils.userDirectory + '/shared/config/'
  shared_lib_dir = @utils.userDirectory + '/shared/lib/'

  # create shared library directory
  directory shared_lib_dir do
    owner node['wlp']['user']
    group node['wlp']['group']
    recursive true
  end

  # source library files
  new_resource.fileset.each do |f|
    remote_file shared_lib_dir + f.name do
      source f.source
      owner node['wlp']['user']
      group node['wlp']['group']
      action :create_if_missing
    end
  end

  # create library config
  library_config_filename = new_resource.name + '.library.xml'

  template shared_config_dir + library_config_filename do
    source 'library.erb'
    owner node['wlp']['user']
    group node['wlp']['group']
    variables({
      id: new_resource.name,
      dir: shared_lib_dir,
      fileset: new_resource.fileset
    })
  end

end

action :destroy do

  shared_config_dir = @utils.userDirectory + '/shared/config/'
  shared_lib_dir = @utils.userDirectory + '/shared/lib/'

  # delete library files
  new_resource.fileset.each do |f|
    f.includes.each do |i|
      file shared_lib_dir + i.name do
        action :delete
      end
    end
  end

  # delete library config
  library_config_filename = new_resource.name + '.library.xml'

  file "#{shared_config_dir}/#{library_config_filename}" do
    action :delete
  end

end

def load_current_resource
  @utils = Liberty::Utils.new(node)
end
