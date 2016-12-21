define udev::rule (
  $ensure   = 'present',
  $trigger  = true,
  $content  = undef,
  $source   = undef,
) {

  validate_re($ensure, '^(present|absent)$')
  validate_bool($trigger)

  if ($content and $source) {
    fail('Please use either $content or $source, not both!')
  }

  if ($content) { validate_string($content) }
  if ($source)  { validate_string($source) }

  if (!$content and !$source) {
    fail('Please define $content or $source!')
  }

  include ::udev::params

  exec { "${::udev::params::udevadm_trigger}":
    refreshonly => true,
  }

  if ($trigger == true and $ensure == 'present') {
    $notify = Exec["${::udev::params::udevadm_trigger}"]
  } else {
    $notify = undef
  }

  file { $title:
    ensure  => $ensure,
    path    => "${::udev::params::udevadm_rules_path}/${title}.rules",
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $content,
    source  => $source,
    notify  => $notify,
  }
}

