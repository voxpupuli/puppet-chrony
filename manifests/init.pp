class chrony (
  $config               = $chrony::params::config,
  $config_template      = $chrony::params::config_template,
  $config_keys          = $chrony::params::config_keys,
  $config_keys_template = $chrony::params::config_keys_template,
  $chrony_password      = $chrony::params::chrony_password,
  $config_keys_owner    = $chrony::params::config_keys_owner,
  $config_keys_group    = $chrony::params::config_keys_group,
  $config_keys_mode     = $chrony::params::config_keys_mode,
  $config_keys_manage   = $chrony::params::config_keys_manage,
  $package_ensure       = $chrony::params::package_ensure,
  $package_name         = $chrony::params::package_name,
  $servers              = $chrony::params::servers,
  $queryhosts           = $chrony::params::queryhosts,
  $port                 = $chrony::params::port,
  $service_enable       = $chrony::params::service_enable,
  $service_ensure       = $chrony::params::service_ensure,
  $service_manage       = $chrony::params::service_manage,
  $service_name         = $chrony::params::service_name,) inherits
chrony::params {

  if ! $config_keys_manage and $chrony_password != 'unset'  {
    fail("Setting \$config_keys_manage false and \$chrony_password at same time in ${module_name} is not possible.")
  }


  include '::chrony::install'
  include '::chrony::config'
  include '::chrony::service'

  anchor { 'chrony::begin': }

  anchor { 'chrony::end': }

  Anchor['chrony::begin'] -> Class['::chrony::install'] -> Class['::chrony::config'
    ] ~> Class['::chrony::service'] -> Anchor['chrony::end']
}
