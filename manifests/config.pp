# This class implements the configuration stage of this module. It should not be called directly.
#
# Configuration file defined with `geoip::config_path` will be created using parameter from
# `geoip::config`.
class geoip::config {
  class { "geoip::config::${geoip::config_version}":
    * => $geoip::config,
  }

  $srv = $facts['service_provider']
  case $srv {
    /systemd/: {
      contain geoip::systemd::service
    }
    default: {
      warn("unknown service provider (${srv}).")
    } # default
  }
}
