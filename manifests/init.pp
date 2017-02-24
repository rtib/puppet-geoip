# Class: geoip
# ===========================
#
# Full description of class geoip here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'geoip':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class geoip (
  Enum['present', 'absent'] $ensure,
  Array[String]             $packages,
  String                    $package_ensure,
  String                    $config_path,
  Struct[{
    userid                     => String,
    licensekey                 => String,
    productids                 => Array[String],
    database_directory         => Optional[String],
    protocol                   => Optional[String],
    proxy                      => Optional[String],
    proxy_user_password        => Optional[String],
    skip_hostname_verification => Optional[Enum[0,1]],
    skip_peer_verification     => Optional[Enum[0,1]],
  }]                        $config,
  Boolean                   $manage_service,
  String                    $update_path,
  String                    $service_name,
  String                    $update_path
) {
  class{ 'geoip::install': } ->
  class{ 'geoip::config': } ->
  class{ 'geoip::update': }
}
