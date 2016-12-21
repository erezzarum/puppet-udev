class udev::params {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $udevadm_path       = '/sbin/udevadm'
      $udevadm_rules_path = '/etc/udev/rules.d'
      $udevadm_trigger    = 'trigger'
    }
    default: {
      fail("The module is not supported on an ${::osfamily} based system")
    }
  }
}