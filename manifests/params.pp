# = Class: dnsmasq::params
#
# This class is private to the dnsmasq implementation
#
# == Parameters:
#
# [*ensure*]
#   Parameter passed to ensure attribute of package resource for
#   dnsmasq
#   Default: installed
#
# [*version*]
#   Specific version if required
#   Default: false
#
# [*autoupgrade*]
#   Flag for taking latest version available
#   Default: false
#
class dnsmasq::params (
  $ensure = 'installed',
  $version = false,
  $autoupgrade = false,
){
  case $::osfamily {
    debian: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
      $config_dir = '/etc/dnsmasq.d/'
      case $::operatingsystem {
        'Ubuntu': {
          $sysv_default = '/etc/default/dnsmasq'
          $service_type = 'upstart'
        }
        default: {
          $service_type = 'init'
        }
      }
    }
    redhat: {
      $package_name = 'dnsmasq'
      $service_name = 'dnsmasq'
      $config_file = '/etc/dnsmasq.conf'
      $config_dir = '/etc/dnsmasq.d/'
      $service_type = 'init'
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
