class chrony::config (
  $config               = $chrony::config,
  $config_template      = $chrony::config_template,
  $config_keys          = $chrony::config_keys,
  $config_keys_template = $chrony::config_keys_template,
  $chrony_password      = $chrony::chrony_password,
  $servers              = $chrony::servers,) inherits chrony {
  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

  file { $config_keys:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0640',
    content => template($config_keys_template),
  }

}
