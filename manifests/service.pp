#
class geoip::service {
  if $geoip::manage_service {
    $srv = $facts['service_provider']
    case $srv {
      /systemd/: {
        include geoip::service::systemd
      } # systemd
      default: {
        fail("unknown service provider (${srv}).")
      } # default
    } # case
  } # if
} # class
