# This class implements the service imlementation for SystemD. It should not be called directly.
class geoip::service::systemd (
  String $restart = 'on-abnormal',
  String $restart_sec = '5min',
) {
  systemd::unit_file{ "${geoip::service_name}.service":
    ensure  => $geoip::ensure,
    content => epp('geoip/service_unit.epp'),
  }

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
}
