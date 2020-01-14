# @summary Configures chrony
#
# @api private
class chrony::config (
  $bindcmdaddress       = $chrony::bindcmdaddress,
  $cmdport              = $chrony::cmdport,
  $cmdacl               = $chrony::cmdacl,
  $commandkey           = $chrony::commandkey,
  $config               = $chrony::config,
  $config_template      = $chrony::config_template,
  $config_keys          = $chrony::config_keys,
  $config_keys_template = $chrony::config_keys_template,
  $config_keys_owner    = $chrony::config_keys_owner,
  $config_keys_group    = $chrony::config_keys_group,
  $config_keys_mode     = $chrony::config_keys_mode,
  $config_keys_manage   = $chrony::config_keys_manage,
  $chrony_password      = $chrony::chrony_password,
  $keys                 = $chrony::keys,
  $log_options          = $chrony::log_options,
  $refclocks            = $chrony::refclocks,
  $mailonchange         = $chrony::mailonchange,
  $threshold            = $chrony::threshold,
  $lock_all             = $chrony::lock_all,
  $peers                = $chrony::peers,
  $servers              = $chrony::servers,
  $pools                = $chrony::pools,
  $port                 = $chrony::port,
  $leapsecmode          = $chrony::leapsecmode,
  $maxslewrate          = $chrony::maxslewrate,
  $smoothtime           = $chrony::smoothtime,
  $stratumweight        = $chrony::stratumweight,
) inherits chrony {
  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

  file { $config_keys:
    ensure  => file,
    replace => $config_keys_manage,
    owner   => $config_keys_owner,
    group   => $config_keys_group,
    mode    => $config_keys_mode,
    content => Sensitive(template($config_keys_template)),
  }

}
