# geoip

## Project status

GitHub: [![GitHub issues](https://img.shields.io/github/issues/rtib/puppet-geoip.svg)](https://github.com/rtib/puppet-geoip/issues) ![GitHub tag](https://img.shields.io/github/commit-activity/y/rtib/puppet-geoip) ![GitHub](https://img.shields.io/github/last-commit/rtib/puppet-geoip)

Nightly CI Workflow: [![CI](https://github.com/rtib/puppet-geoip/actions/workflows/ci.yaml/badge.svg)](https://github.com/rtib/puppet-geoip/actions/workflows/ci.yaml)

Puppet Forge: ![PDK Version](https://img.shields.io/puppetforge/pdk-version/trepasi/geoip.svg) [![Puppet Forge](https://img.shields.io/puppetforge/v/trepasi/geoip.svg)](https://forge.puppet.com/trepasi/geoip)

## Table of Contents

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=3 orderedList=false} -->

<!-- code_chunk_output -->

- [geoip](#geoip)
  - [Project status](#project-status)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [What geoip affects](#what-geoip-affects)
    - [Setup Requirements](#setup-requirements)
    - [Beginning with geoip](#beginning-with-geoip)
  - [Usage](#usage)
    - [Configuring versions less than 3.1.1](#configuring-versions-less-than-311)
    - [Configuring versions 3.1.1 and later](#configuring-versions-311-and-later)
    - [Upgrading to 3.1.1 or later](#upgrading-to-311-or-later)
    - [Updating databases](#updating-databases)
    - [Update scheduling](#update-scheduling)
  - [Reference](#reference)
  - [Limitations](#limitations)
    - [Debian 11 - Bullseye](#debian-11---bullseye)
  - [Development](#development)
  - [Copyright](#copyright)

<!-- /code_chunk_output -->

## Description

This Puppet module installs and maintains tools and processes to use GeoIP databases
from [MaxMind][1]. These include the lookup tools for lookup and update the databases. It will manage the configuration for the
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
contain geoip
```

All configuration parameter can be assigned hiera. The default values are also lookuped up by hiera using the database shipped with the module.

## Usage

Note, that MaxMind does not allow to download databases without subscription, but there is a free tier which can be used to download three GeoLite2 databases.

The configuration depends on the version of the `geoipupdate` tool to use, as there is a difference between versions starting at 3.1.1 and the older ones. The module referns to these settings via parameter `geoip::config_version` using the value `lt311` for versions less than 3.1.1 and value `ge311` for version greater or equal to 3.1.1.

### Configuring versions less than 3.1.1

```yaml
geoip::config:
  userid: '<yourAccountID>'
  licensekey: '<yourLicenseKey>'
```

Replace the values for `userid` and `licensekey` with actual data from your subscription.

Optional configuration settings are available, enable to set:

- `productids`: array of productids of the databases you want to download; it defaults to the freely available databases `['GeoLite2-ASN', 'GeoLite2-City', 'GeoLite2-Country']`
- `database_directory`: where to store the database files
- `protocol`: HTTP or HTTPS
- `proxy`: URL to the Proxy service allowing access to the Internet
- `proxy_user_password`: Username and password to the Proxy, if needed.
- `skip_hostname_verification`: Disable hostname verification.
- `skip_peer_verification`: Disable certificate validation.

Refer to your subscription to get the list of `productids` you are allowed to use.

### Configuring versions 3.1.1 and later

```yaml
geoip::config:
  accountid: '<yourAccountID>'
  licensekey: '<yourLicenseKey>'
```

Replace the values for `accountid` and `licensekey` with actual data from your subscription.

Optional configuration settings are available, enable to set:

- `editionids`: array of IDs of the databases you want to download; it defaults to the freely available databases `['GeoLite2-ASN', 'GeoLite2-City', 'GeoLite2-Country']`
- `database_directory`: where to store the database files
- `host`: the update server to use
- `proxy`: URL to the Proxy service allowing access to the Internet
- `proxy_user_password`: Username and password to the Proxy, if needed.
- `lock_file`: location of the lock file to use to prevent running multiple updates at the same time

Refer to your subscription to get the list of `editionids` you are allowed to use.

### Upgrading to 3.1.1 or later

Versions of `geoipupdate` 3.1.1 or later will accept the configuration file format of former versions. Making use of that, the module provides the `geoip::config_version` parameter to chose the configuration format, which defaults to `lt311`, but is overwritten with `ge311` for operating system versions known to provide geoipupdate version 3.1.1 or later (e.g. Debian Buster). While it should not needed to set this parameter in normal operation, during upgrade of multiple nodes, the parameter allows to pin the configuration version to the needed format.

Note, that a license keys issued for versions less than 3.1.1 of later will not work in both configurations, `geoipupdate` versions less than 3.1.1 will fail accessing the update server when a key issed for 3.1.1 or later is provided in the `lt311` configuration.

### Updating databases

In order to update your databases you may use the `geoipupdate` tool with the configuration file created by this puppet module.

If you haven't disabled `geoip::manage_service`, you may start the update service named `geoip::service_name` (defaults to `geoip_update`), which will do the update.

By default, the update service will retry after 5 minutes if the update was failed by any reason. This behaviour can be changed via `geoip::systemd::service::restart` and `geoip::systemd::service::restart_sec` defining SystemD restart behaviour.

### Update scheduling

Updates, if handled by SystemD, can be scheduled by setting `geoip::update_timers` an array of timer descriptions. These timer descriptions apply on systemd timer unit OnCalendar options. For correct syntax of these timestamps see [systemd.time(7)#Parsing Timestamps](https://www.freedesktop.org/software/systemd/man/systemd.time.html#Parsing%20Timestamps).

The parameter `geoip::update_scatter` defines the seconds for systemd timer AccuracySec option (see [systemd.timer(5)#AccuracySec](https://www.freedesktop.org/software/systemd/man/systemd.timer.html#AccuracySec=)) to prevent multiple nodes to update at the same time.

## Reference

Automatically generated reference documentation is available in the [REFERENCE.md][2] file or at [https://rtib.github.io/puppet-geoip/][3].

## Limitations

For supported operating systems and dependencies, see [metadata.json](https://github.com/rtib/puppet-cassandra/blob/main/metadata.json).

Extensive itegration tests are run nightly to assure quality  and compatibility with next releases.

### Debian 11 - Bullseye

The `geoipupdate` package available in Debian Bullseye release is shipping SystemD units for service and timer to conduct weekly updates of the database. Default behaviour of the module will shift to use `systemd_config: dropin` on Debian-11 by default to rebuild the functionality on the changed environment.

## Development

The module is developed using recent [Puppet Development Kit][4], [validated][5] and extensively tested using [Puppet Litmus][6]. Automated workflows, implemented with [GitHub Actions][7] are run on demand and nightly, doing validation, spec tests and continuous integration tests.

Note, that [CI-Acceptance](https://github.com/rtib/puppet-geoip/actions/workflows/ci-acceptance.yaml) workflow is not applied to pull requests automatically, as it needs credentials setup as secrets to work. A pull request, however, will only be merged if these tests also succeed.

As an open project, you are welcome to contribute to this module. Currently, there is no contribution guide specific to this module, general information about the workflow may apply. In case of questions feel free to open a issue or join community Slack channels #forge-modules, #puppet, #puppet-dev, #testing on slack.puppet.com.

Issues and pull requests will be addressed in a timely manner, according to community best practice. Releases are going to be published on demand, after having merged an set of sufficiently important changes and all tests succeeded. There may be automated rule enforcement in place to provide a healthy issue lifecycle.

## Copyright

This product is tested using GeoLite2 data created by MaxMind, available from [https://www.maxmind.com][1].

[1]: https://www.maxmind.com
[2]: https://github.com/rtib/puppet-geoip/blob/main/REFERENCE.md
[3]: https://rtib.github.io/puppet-geoip/
[4]: https://puppet.com/docs/pdk/2.x/pdk.html
[5]: https://puppet.com/docs/pdk/1.x/pdk_testing.html
[6]: https://github.com/puppetlabs/puppet_litmus
[7]: https://docs.github.com/en/actions
