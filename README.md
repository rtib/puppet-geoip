# geoip

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with geoip](#setup)
    * [What geoip affects](#what-geoip-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with geoip](#beginning-with-geoip)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This Puppet module installs and maintains tools and processes to use GeoIP databases
from MaxMind. These include the lookup tools geoiplookup and mmdb-lookup, and the 
geoipupdate tool to update the databases. It will manage the configuration for the
update tool which enables to set your subscription settings, product IDs and other
settings, e.g. proxy settings. If systemd is available, a service is defined in order 
to enable a seamless update process, which can be triggered at any time or scheduled
by cron, a systemd timer unit, puppet or any other scheduler.

## Setup

### What geoip affects

The module will install some packages, create a configuration file and a systemd
service unit.

### Setup Requirements

Neccesary packages must be available for installation by the package management tools
used on the target system. As this is not the case on many systems, you have to take care
about the availability of the packages. The list of the packages to be installed is a 
configuration option.

### Beginning with geoip

The only thing to start with geoip is to include the class in the manifest of your nodes.

```
include ::geoip
```

All configuration parameter are assigned automatically, using Puppet 4's automatic parameter
lookup feature. This enables the module to be configured fully over your hiera database. The
default values are also lookuped up by hiera using the database shipped with the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
