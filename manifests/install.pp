#
class geoip::install {
  $pkg_ensure = $geoip::ensure ? {
    /present/ => $geoip::package_ensure,
    default   => $geoip::ensure,
  }

  package{ $geoip::packages:
    ensure => $pkg_ensure,
  }
}
