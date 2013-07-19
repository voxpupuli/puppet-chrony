class chrony (
  $autoupdate           = $chrony::params::autoupdate,
  $config               = $chrony::params::config,
  $config_template      = $chrony::params::config_template,
  $config_keys          = $chrony::params::config_keys,
  $config_keys_template = $chrony::params::config_keys_template,
  $chrony_password      = $chrony::params::chrony_password,
  $package_ensure       = $chrony::params::package_ensure,
  $package_name         = $chrony::params::package_name,
  $servers              = $chrony::params::servers,
  $service_enable       = $chrony::params::service_enable,
  $service_ensure       = $chrony::params::service_ensure,
  $service_manage       = $chrony::params::service_manage,
  $service_name         = $chrony::params::service_name,) inherits
chrony::params {
  if $autoupdate {
    notice('autoupdate parameter has been deprecated
    and replaced with package_ensure.
    Set this to latest for the same behavior as autoupdate => true.')
  }

  include '::chrony::install'
  include '::chrony::config'
  include '::chrony::service'

  # Anchor this as per #8140 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'chrony::begin': }

  anchor { 'chrony::end': }

  Anchor['chrony::begin'] -> Class['::chrony::install'] -> Class['::chrony::config'
    ] ~> Class['::chrony::service'] -> Anchor['chrony::end']
}
