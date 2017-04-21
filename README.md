# WebSphere Liberty Profile Cookbook

The wlp_wrapper cookbook is a wrapper cookbook for the [wlp_cookbook](https://supermarket.chef.io/cookbooks/wlp).

## Requirements

### Platforms

- Centos 7+

### Chef

- Chef 12.19

### Dependent Cookbooks

- wlp 0.3.0+

## Recipes

### default

## Usage

### Applications

```ruby
wlp: {
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
      },
      application: [
        {
          remote_file: 'https://bintray.com/monkeylittle/maven/download_file?file_path=org%2Fspringframework%2Fsamples%2Fspring-petclinic%2F4.3.6%2Fspring-petclinic-4.3.6.war',
          checksum: '6fbc5099ef5fa621a1f9abf15081fc9c325768cbf31db7eef755efcaa4176037',
          name: 'spring-petclinic',
          type: 'war',
          'context-root': 'spring-petclinic',
          autoStart: true
        }
      ]
    }
  }
}
```

### Shared Libraries

Shared libraries are files used by multiple applications (and servers).  They are used to reduce the number of duplicate library files on the system.  The shared library specifies a set of resources (for example JAR files).

The shared library can be referenced by name within an application or server element so that it is loaded by the corresponding classloader.

```ruby
wlp: {
  libraries: {
    mysql5: {
      fileset: [
        { name:'mysql-connector-java-5.1.41.jar', source: 'https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar' }
      ]
    }
  }
}
```
