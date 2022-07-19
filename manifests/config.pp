# @summary Configures chrony
#
# @api private
class chrony::config {
  assert_private()

  file { $chrony::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => epp($chrony::config_template,
      {
        servers => chrony::server_array_to_hash($chrony::servers, ['iburst']),
        pools   => chrony::server_array_to_hash($chrony::pools, ['iburst']),
        peers   => chrony::server_array_to_hash($chrony::peers),
      }
    ),
  }

  if $chrony::chrony_password =~ Sensitive {
    # unwrap before Puppet 6.24 can only be called on Sensitive values
    $chrony_password = $chrony::chrony_password.unwrap
  } else {
    $chrony_password = $chrony::chrony_password
  }

  $keys_params = {
    'chrony_password' => $chrony_password,
    'commandkey' => $chrony::commandkey,
    'keys' => $chrony::keys,
  }

  unless empty($chrony::config_keys) {
    file { $chrony::config_keys:
      ensure  => file,
      replace => $chrony::config_keys_manage,
      owner   => $chrony::config_keys_owner,
      group   => $chrony::config_keys_group,
      mode    => $chrony::config_keys_mode,
      content => Sensitive(epp($chrony::config_keys_template, $keys_params)),
    }
  }
}
