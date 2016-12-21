define udev::rule (
  $ensure   = 'present',
  $trigger  = true,
  $content  = undef,
  $source   = undef,
) {

  include ::udev

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

  if ($trigger == true and $ensure == 'present') {
    $notify = Class['::udev::trigger']
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

