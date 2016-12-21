class udev::trigger (
  $udevadm_trigger = undef
) {

  if ($udevadm_trigger == undef) {
    fail('You must define $udevadm_trigger')
  }

  validate_string($udevadm_trigger)

  exec { $udevadm_trigger:
    refreshonly => true,
  }

}