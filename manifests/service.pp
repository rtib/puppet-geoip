# This class implements the service control stage of the module. It should not be called directly.
#
# If `geoip::manage_service` enabled, an update service will be created fitting to the service
# provider available on the node. Service name is configured with `geoip::service_name`.
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
