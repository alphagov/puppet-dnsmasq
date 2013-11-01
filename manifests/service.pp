# = Class: dnsmasq::service
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::service {
  if $dnsmasq::params::service_type == 'upstart' {
    file { "/etc/init/${dnsmasq::params::service_name}.conf":
      source => 'puppet:///modules/dnsmasq/etc/init/dnsmasq.conf',
      before => Service[$dnsmasq::params::service_name],
    }
  }
  service { $dnsmasq::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
