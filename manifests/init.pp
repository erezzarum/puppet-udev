class udev (
  $udev_rules = {}
) {
  validate_hash($udev_rules)
  if ($udev_rules != {}) {
    create_resources('::udev::rule', $udev_rules)
  }
}