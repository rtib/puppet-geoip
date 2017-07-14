#
class geoip::config {
  $cfg_ensure = $geoip::ensure ? {
    /present/ => 'file',
    default   => $geoip::ensure,
  }

  file{ $geoip::config_path:
    ensure  => $cfg_ensure,
    content => epp('geoip/GeoIP.conf.epp'),
    mode    => '0640',
    group   => 0,
    owner   => 0,
  }
}
