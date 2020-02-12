class geoip::config::lt311(
  String $userid,
  String $licensekey,
  Array[String] $productids = ['GeoLite2-City','GeoLite2-Country'],
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

  file{ $geoip::config_path:
    ensure  => $cfg_ensure,
    content => epp('geoip/GeoIP.conf.lt311.epp'),
    mode    => '0640',
    group   => 0,
    owner   => 0,
  }
}
