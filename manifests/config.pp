# @summary Configures chrony
#
# @api private
class chrony::config (
  $bindcmdaddress       = $chrony::bindcmdaddress,
  $cmdacl               = $chrony::cmdacl,
  $cmdport              = $chrony::cmdport,
  $commandkey           = $chrony::commandkey,
  $config               = $chrony::config,
  $config_template      = $chrony::config_template,
  $config_keys          = $chrony::config_keys,
  $config_keys_template = $chrony::config_keys_template,
  $chrony_password      = $chrony::chrony_password,
  $config_keys_owner    = $chrony::config_keys_owner,
  $config_keys_group    = $chrony::config_keys_group,
  $config_keys_mode     = $chrony::config_keys_mode,
  $config_keys_manage   = $chrony::config_keys_manage,
  $keys                 = $chrony::keys,
  $local_stratum        = $chrony::local_stratum,
  $log_options          = $chrony::log_options,
  $refclocks            = $chrony::refclocks,
  $peers                = $chrony::peers,
  $servers              = $chrony::servers,
  $pools                = $chrony::pools,
  $makestep_seconds     = $chrony::makestep_seconds,
  $makestep_updates     = $chrony::makestep_updates,
  $queryhosts           = $chrony::queryhosts,
  $mailonchange         = $chrony::mailonchange,
  $threshold            = $chrony::threshold,
  $lock_all             = $chrony::lock_all,
  $port                 = $chrony::port,
  $clientlog            = $chrony::clientlog,
  $clientloglimit       = $chrony::clientloglimit,
  $smoothtime           = $chrony::smoothtime,
  $leapsecmode          = $chrony::leapsecmode,
  $leapsectz            = $chrony::leapsectz,
  $maxslewrate          = $chrony::maxslewrate,
  $stratumweight        = $chrony::stratumweight,
  $rtconutc             = $chrony::rtconutc,
) {
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
