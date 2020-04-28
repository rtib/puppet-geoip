# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include geoip::systemd::service
class geoip::systemd::service (
  String $restart = 'on-abnormal',
  String $restart_sec = '5min',
) {
  systemd::unit_file{ "${geoip::service_name}.service":
    ensure  => $geoip::ensure,
    content => epp('geoip/service_unit.epp'),
  }
}
