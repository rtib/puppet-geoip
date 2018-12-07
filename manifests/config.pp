# This class implements the configuration stage of this module. It should not be called directly.
#
# Configuration file defined with `geoip::config_path` will be created using parameter from
# `geoip::config`.
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
