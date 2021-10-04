# @summary Controling SystemD service unit for update
#
# This class is creating a serivce unit for SystemD to update GeoIP databases.
# The service is running the geoipupdate ones and retry as configured.
#
# @param restart update service retry behaviour
# @param restart_sec time to wait before retry
class geoip::systemd::service (
  String                 $restart = 'on-failure',
  String                 $restart_sec = '5min',
) {
  if $geoip::systemd_config == 'unit' {
    systemd::unit_file{ "${geoip::service_name}.service":
      ensure  => $geoip::ensure,
      content => epp('geoip/service_unit.epp'),
    }
  } elsif $geoip::systemd_config == 'dropin' {
    systemd::dropin_file { '10-exec.conf':
      unit    => "${geoip::service_name}.service",
      content => epp('geoip/service_dropin_10.epp'),
    }
    systemd::dropin_file { '20-user-log.conf':
      unit    => "${geoip::service_name}.service",
      content => epp('geoip/service_dropin_20.epp'),
    }
    if versioncmp($facts['systemd_version'], '240') >= 0 {
      systemd::dropin_file { '30-restart.conf':
        unit    => "${geoip::service_name}.service",
        content => epp('geoip/service_dropin_30.epp'),
      }
    }
  }
}
