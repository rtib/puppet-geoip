# This class implements the installation stage of the module. It should not be called directly.
#
# This will install or remove software packages listed in `geoip::packages`. When installing
# package versions will be ensured as `geoip::package_ensure`.
class geoip::install {
  $pkg_ensure = $geoip::ensure ? {
    /present/ => $geoip::package_ensure,
    default   => $geoip::ensure,
  }

  package{ $geoip::packages:
    ensure => $pkg_ensure,
  }
}
