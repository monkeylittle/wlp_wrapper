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

### Shared Libraries

Shared libraries are files used by multiple applications (and servers).  They are used to reduce the number of duplicate library files on the system.  The shared library specifies a set of resources (for example JAR files).

The shared library can be referenced by name within an application or server element so that it is loaded by the corresponding classloader.

```ruby
wlp: {
  libraries: {
    mysql5: {
      id: 'mysql5',
      serverName: 'defaultServer',
      fileset: [
        {
          includes: [
              { name:'mysql-connector-java-5.1.41.jar', source: 'https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.41/mysql-connector-java-5.1.41.jar' }
          ]
        }
      ]
    }
  }
}
```
