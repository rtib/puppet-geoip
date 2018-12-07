# geoip

Project state:

GitHub: [![GitHub issues](https://img.shields.io/github/issues/rtib/puppet-geoip.svg)](https://github.com/rtib/puppet-geoip/issues) [![GitHub license](https://img.shields.io/github/license/rtib/puppet-geoip.svg)](https://github.com/rtib/puppet-geoip/blob/master/LICENSE) [![GitHub tag](https://img.shields.io/github/tag/rtib/puppet-geoip.svg)](https://github.com/rtib/puppet-geoip/releases)

Travis-CI: [![Build Status](https://travis-ci.org/rtib/puppet-geoip.svg?branch=master)](https://travis-ci.org/rtib/puppet-geoip)

Puppet Forge: [![Puppet Forge](https://img.shields.io/puppetforge/v/trepasi/geoip.svg)](https://forge.puppet.com/trepasi/geoip) [![Puppet Forge](https://img.shields.io/puppetforge/f/trepasi/geoip.svg)](https://forge.puppet.com/trepasi/geoip) [![Puppet Forge](https://img.shields.io/puppetforge/dt/trepasi/geoip.svg)](https://forge.puppet.com/trepasi/geoip)

## Table of Contents


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [geoip](#geoip)
    - [Table of Contents](#table-of-contents)
    - [Description](#description)
    - [Setup](#setup)
        - [What geoip affects](#what-geoip-affects)
        - [Setup Requirements](#setup-requirements)
        - [Beginning with geoip](#beginning-with-geoip)
    - [Usage](#usage)
        - [Updating databases](#updating-databases)
    - [Reference](#reference)
    - [Development](#development)

<!-- /code_chunk_output -->

## Description

This Puppet module installs and maintains tools and processes to use GeoIP databases
from MaxMind. These include the lookup tools for lookup and update the databases. It will manage the configuration for the
update tool which enables to set up your subscription settings, product IDs and other
settings, e.g. proxy settings. If systemd is available, a service is defined in order
to enable a seamless update process.

## Setup

### What geoip affects

The module will install some packages, create a configuration file and a systemd
service unit.

### Setup Requirements

Neccesary packages must be available for installation by the package management tools
used on the target system. As this is not the case on many systems, you have to take care
about the availability of the packages. The list of the packages to be installed is a configuration option.

### Beginning with geoip

The only thing to start with geoip is to include the class in the manifest of your nodes.

```puppet
include geoip
```

All configuration parameter can be assigned hiera. The default values are also lookuped up by hiera using the database shipped with the module.

## Usage

All configuration parameter can be set using hiera. The default values allow you to download all free available geoip databases from MaxMind.

```yaml
geoip::config:
  userid: '999999'
  licensekey: '000000000000'
  productids:
    - GeoLite2-City
    - GeoLite2-Country
```

If you have a subscription, add userid and licensekey to your hiera, along with the productids your subscription is valid for and you want to download.
Note, that this configuration will only be active at the next update.

Optional configuration settings are available, enable to set:

* `database_directory`: where to store the database files
* `protocol`: HTTP or HTTPS
* `proxy`: URL to the Proxy service allowing access to the Internet
* `proxy_user_password`: Username and password to the Proxy, if needed.
* `skip_hostname_verification`: Disable hostname verification.
* `skip_peer_verification`: Disable certificate validation.

### Updating databases

In order to update your databases you may use the `geoipupdate` tool with the configuration file created by this puppet module.

If you haven't disabled `geoip::manage_service`, you may start the update service named `geoip::service_name` (defaults to `geoip_update`), which will do the update.

## Reference

Generated reference documentation is available at [https://rtib.github.io/puppet-geoip/](https://rtib.github.io/puppet-geoip/).

## Development

According to its license, you are free to contribute changes to this module. You may aware of the general workflows when contributing to GitHub projects, if not yet, please read CONTRIBUTING.md.
