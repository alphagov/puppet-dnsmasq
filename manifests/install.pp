# = Class: dnsmasq::install
#
# This class is private to the dnsmasq implementation
#
class dnsmasq::install {
  if $dnsmasq::params::service_type == 'upstart' {
    # Disable dnsmasq init.d service
    #
    # On systems where the service starts automatically on
    # installation, dnsmasq can cause problems because it immediately
    # registers itself as the sole resolver in resolvconf, but it
    # takes a while for resolvconf to inform dnsmasq of the upstream
    # servers in /var/run/dnsmasq/resolv.conf. During this time, ALL
    # DNS LOOKUPS FAIL, which is Very Bad News for your puppet run.
    file { $::dnsmasq::params::sysv_default:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "ENABLED=0\n",
      before  => Package[$dnsmasq::params::package_name],
    }
  }
  #### Package management
  # set params: in operation
  if $dnsmasq::params::ensure == 'installed' {

    # Check if we want to install a specific version or not
    if $dnsmasq::params::version == false {

      $package_ensure = $dnsmasq::params::autoupgrade ? {
        true  => 'latest',
        false => 'installed',
      }

    } else {
      # install specific version
      $package_ensure = $dnsmasq::params::version

    }

  # set params: removal
  } else {
    $package_ensure = 'purged'
  }

  package { $dnsmasq::params::package_name:
    ensure => $package_ensure,
  }
}
