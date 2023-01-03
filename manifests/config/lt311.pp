# This class is creating a GeoIP.conf configuration file for geoipupdate
# versions < 3.1.1.
#
# @param userid UserID of your MaxMind subscription
# @param licensekey The license key issued by MaxMind to be used
# @param productids Product IDs to download
# @param database_directory Path where the database file to be stored
# @param protocol Protocol to be used when accessing the update server
# @param proxy URL or IP:Port of the proxy to use when accessing the update server
# @param proxy_user_password Credentials as username:password for proxy authentication
# @param skip_hostname_verification Whether to skip host name verification on HTTPS connections
# @param skip_peer_verification Whether to skip peer verification on HTTPS connections
class geoip::config::lt311 (
  String $userid,
  String $licensekey,
  Array[String] $productids = ['GeoLite2-ASN','GeoLite2-City','GeoLite2-Country'],
  Optional[Stdlib::Absolutepath] $database_directory = undef,
  Optional[Enum['http','https']] $protocol = undef,
  Optional[String] $proxy = undef,
  Optional[String] $proxy_user_password = undef,
  Optional[Boolean] $skip_hostname_verification = undef,
  Optional[Boolean] $skip_peer_verification = undef,
) {
  $cfg_ensure = $geoip::ensure ? {
    /present/ => 'file',
    default   => $geoip::ensure,
  }

  file { $geoip::config_path:
    ensure  => $cfg_ensure,
    content => epp('geoip/GeoIP.conf.lt311.epp'),
    mode    => '0640',
    group   => 0,
    owner   => 0,
  }
}
