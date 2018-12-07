# The geoip module installs tools and databases GeoIP resolution from MaxMind.
#
# @example hiera
#     geoip::config:
#       userid: '999999'
#       licensekey: '000000000000'
#       productids:
#         - GeoLite2-City
#         - GeoLite2-Country
#       database_directory:
#       protocol:
#       proxy:
#       proxy_user_password:
#       skip_hostname_verification:
#       skip_peer_verification:
#   
# You may replace userid and licensekey with your subscription and
# add the productids you want to sync. Leaving these options on default
# will allow you to sync all free available databases. With
# database_directory the destination directory of the databases can be
# set, protocol, proxy* and *_verification may only be needed in the
# case your host needs some specific proxy settings to get to the
# internet.
#
# @param ensure install or remove settings done by this module
# @param packages the software packages containing the tools to be installed
# @param package_ensure which version of the packages should be ensured
# @param config_path path to the configuration and license file
# @param config hash of configuration options
# @param manage_service whether to manage database updating service
# @param update_path path to the geoipupdate tool, used by update service
# @param service_name name of the update service
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
    protocol                   => Optional[Enum['http','https']],
    proxy                      => Optional[String],
    proxy_user_password        => Optional[String],
    skip_hostname_verification => Optional[Boolean],
    skip_peer_verification     => Optional[Boolean],
  }]                        $config,
  Boolean                   $manage_service,
  String                    $update_path,
  String                    $service_name,
) {
  contain geoip::install
  contain geoip::config
  contain geoip::service

  Class['geoip::install']
  -> Class['geoip::config']
  ~> Class['geoip::service']
}
