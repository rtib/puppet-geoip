# This class is creating a GeoIP.conf configuration file for geoipupdate
# versions >= 3.1.1.
#
# @param accountid AccountID of your MaxMind subscription
# @param licensekey The license key issued by MaxMind to be used
# @param editionids Edition IDs (formerly known as ProductIDs) to download
# @param database_directory Path where the database file to be stored
# @param host The update server to use
# @param proxy URL or IP:Port of the proxy to use when accessing the update server
# @param proxy_user_password Credentials as username:password for proxy authentication
# @param preserve_file_times Whether to preserve modification times of files downloaded from the server
# @param lock_file The lock file to use
class geoip::config::ge311(
  String $accountid,
  String $licensekey,
  Array[String] $editionids = ['GeoLite2-ASN','GeoLite2-City','GeoLite2-Country'],
  Optional[Stdlib::Absolutepath] $database_directory = undef,
  Optional[String] $host = undef,
  Optional[String] $proxy = undef,
  Optional[String] $proxy_user_password = undef,
  Optional[Boolean] $preserve_file_times = undef,
  Optional[String] $lock_file = undef,
) {
  $cfg_ensure = $geoip::ensure ? {
    /present/ => 'file',
    default   => $geoip::ensure,
  }

  file{ $geoip::config_path:
    ensure  => $cfg_ensure,
    content => epp('geoip/GeoIP.conf.ge311.epp'),
    mode    => '0640',
    group   => 0,
    owner   => 0,
  }
}
