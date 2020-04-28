# @summary Controling SystemD service unit for update
#
# This class is creating a serivce unit for SystemD to update GeoIP databases.
# The service is running the geoipupdate ones and retry as configured.
#
# @param restart update service retry behaviour
# @param restart_sec time to wait before retry
class geoip::systemd::service (
  String $restart = 'on-failure',
  String $restart_sec = '5min',
) {
  systemd::unit_file{ "${geoip::service_name}.service":
    ensure  => $geoip::ensure,
    content => epp('geoip/service_unit.epp'),
  }
}
