# This class implements the service imlementation for SystemD. It should not be called directly.
class geoip::service::systemd {
  systemd::unit_file{ "${geoip::service_name}.service":
    ensure  => $geoip::ensure,
    content => epp('geoip/service_unit.epp'),
  }
}
