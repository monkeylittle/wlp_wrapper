# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = 'websphere-liberty-profile'

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = '12.19.36'
  end

  config.vm.box = "bento/centos-7.2"

  config.vm.network :private_network, type: 'dhcp'

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      java: {
        install_flavor: 'oracle',
        jdk_version: '8',
        oracle: {
          accept_oracle_download_terms: true
        }
      },

      wlp: {
        archive: {
          accept_license: true,
          extended: {
            install: true
          },
          extras: {
            install: false
          }
        },

        servers: {
          defaultServer: {
            enabled: true,
            description: 'Default Server',
            featureManager: {
              feature: [ 'jsp-2.2' ]
            },
            httpEndpoint: {
              id: 'defaultHttpEndpoint',
              host: '*',
              httpPort: '8080',
              httpsPort: '8443'
            }
          }
        },

        libraries: {
          mysql5: {
            fileset: [
              { name:'mysql-connector-java-5.1.41.jar', source: 'https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar' }
            ]
          }
        }
      }
    }

    chef.run_list = [
      'recipe[wlp_wrapper::default]'
    ]
  end
end
