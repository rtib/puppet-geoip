# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include geoip::systemd::timer
class geoip::systemd::timer {
  if $geoip::update_timers.length > 0 {
    systemd::unit_file{ "${geoip::service_name}.timer":
      ensure  => $geoip::ensure,
      content => epp('geoip/timer_unit.epp'),
    }
    -> service { "${geoip::service_name}.timer":
      ensure => 'running',
      enable => true,
    }
  } else {
    service { "${geoip::service_name}.timer":
      ensure => 'stopped',
      enable => false,
    }
  }
}
