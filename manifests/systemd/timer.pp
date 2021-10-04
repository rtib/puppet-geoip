# @summary Controll the SystemD Timer unit
#
# This class will create a SystemD timer unit triggering the update service on
# each wallclock timer.
#
# @param overwrite_wallclocks if systemd_config is set to dropin, the existing timer may already have wallclocks, this aboud to overwrite or append them
#
class geoip::systemd::timer(
  Boolean $overwrite_wallclocks = true,
) {
  if $geoip::systemd_config == 'unit' {
    if $geoip::update_timers.length > 0 {
      systemd::unit_file{ "${geoip::service_name}.timer":
        ensure  => $geoip::ensure,
        content => epp('geoip/timer_unit.epp'),
      }
      ~> service { "${geoip::service_name}.timer":
        ensure => 'running',
        enable => true,
      }
    } else {
      service { "${geoip::service_name}.timer":
        ensure => 'stopped',
        enable => false,
      }
    }
  } elsif $geoip::systemd_config == 'dropin' {
    systemd::dropin_file { '10-head.conf':
      unit    => "${geoip::service_name}.timer",
      content => epp('geoip/timer_dropin_10.epp'),
    }
    if $overwrite_wallclocks {
      systemd::dropin_file { '20-clearclocks.conf':
        unit    => "${geoip::service_name}.timer",
        content => epp('geoip/timer_dropin_20.epp'),
      }
    }
    if $geoip::update_timers.length > 0 {
      systemd::dropin_file { '30-wallclocks.conf':
        unit    => "${geoip::service_name}.timer",
        content => epp('geoip/timer_dropin_30.epp'),
      }
    }
  }
}
