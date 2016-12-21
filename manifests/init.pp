class udev (
  $udevadm_path    = $::udev::params::udevadm_path,
  $udevadm_trigger = $::udev::params::udevadm_trigger,
  $udev_rules      = { }
) inherits udev::params {

  validate_string($udevadm_path)
  validate_string($udevadm_trigger)
  validate_hash($udev_rules)

  class { '::udev::trigger':
    udevadm_trigger => "${udevadm_path} ${udevadm_trigger}",
  }

  if ($udev_rules != { }) {
    create_resources('::udev::rule', $udev_rules)
  }
}