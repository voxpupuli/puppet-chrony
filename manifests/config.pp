# @summary Configures chrony
#
# @api private
class chrony::config (
  $bindaddress          = $chrony::bindaddress,
  $bindcmdaddress       = $chrony::bindcmdaddress,
  $chrony_password      = $chrony::chrony_password,
  $clientlog            = $chrony::clientlog,
  $clientloglimit       = $chrony::clientloglimit,
  $cmdacl               = $chrony::cmdacl,
  $cmdport              = $chrony::cmdport,
  $commandkey           = $chrony::commandkey,
  $config               = $chrony::config,
  $config_keys          = $chrony::config_keys,
  $config_keys_group    = $chrony::config_keys_group,
  $config_keys_manage   = $chrony::config_keys_manage,
  $config_keys_mode     = $chrony::config_keys_mode,
  $config_keys_owner    = $chrony::config_keys_owner,
  $config_keys_template = $chrony::config_keys_template,
  $config_template      = $chrony::config_template,
  $keys                 = $chrony::keys,
  $leapsecmode          = $chrony::leapsecmode,
  $leapsectz            = $chrony::leapsectz,
  $local_stratum        = $chrony::local_stratum,
  $lock_all             = $chrony::lock_all,
  $log_options          = $chrony::log_options,
  $mailonchange         = $chrony::mailonchange,
  $makestep_seconds     = $chrony::makestep_seconds,
  $makestep_updates     = $chrony::makestep_updates,
  $maxslewrate          = $chrony::maxslewrate,
  $maxupdateskew        = $chrony::maxupdateskew,
  $peers                = $chrony::peers,
  $pools                = $chrony::pools,
  $port                 = $chrony::port,
  $queryhosts           = $chrony::queryhosts,
  $refclocks            = $chrony::refclocks,
  $rtconutc             = $chrony::rtconutc,
  $servers              = $chrony::servers,
  $smoothtime           = $chrony::smoothtime,
  $stratumweight        = $chrony::stratumweight,
  $threshold            = $chrony::threshold,
) {
  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => epp($config_template,
      {
        servers => chrony::server_array_to_hash($servers, ['iburst']),
        pools   => chrony::server_array_to_hash($pools, ['iburst']),
        peers   => chrony::server_array_to_hash($peers),
      }
    ),
  }

  file { $config_keys:
    ensure  => file,
    replace => $config_keys_manage,
    owner   => $config_keys_owner,
    group   => $config_keys_group,
    mode    => $config_keys_mode,
    content => Sensitive(epp($config_keys_template)),
  }
}
