class geoip::config::ge311(
  String $accountid,
  String $licensekey,
  Array[String] $editionids = ['GeoLite2-City','GeoLite2-Country'],
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
