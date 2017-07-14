#
class geoip::service::systemd {
  systemd::unit_file{ $geoip::service_name:
    ensure  => $geoip::ensure,
    content => epp('geoip/service_unit.epp'),
  }
}
