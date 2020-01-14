# @summary chrony class parameters
#
# @api private
class chrony::params {
  $commandkey         = 0
  $keys               = []
  $log_options        = undef
  $package_ensure     = 'present'
  $package_provider   = undef
  $package_source     = undef
  $refclocks          = []
  $peers              = []
  $service_enable     = true
  $service_ensure     = 'running'
  $service_manage     = true
  $chrony_password    = 'xyzzy'
  $queryhosts         = []
  $local_stratum      = 10
  $port               = 0
  $config_keys_manage = true
  $mailonchange       = undef
  $threshold          = 0.5
  $lock_all           = false
  $clientloglimit     = undef
  $cmdport            = undef
  $smoothtime         = undef
  $leapsecmode        = undef
  $maxslewrate        = undef
  $stratumweight      = undef

  case $::osfamily {
    'Archlinux' : {
      $cmdacl            = ['cmdallow 127.0.0.1']
      $config            = '/etc/chrony.conf'
      $config_template   = 'chrony/chrony.conf.archlinux.erb'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $service_name      = 'chrony'
      $clientlog         = true
    }
    'Suse', 'RedHat' : {
      $cmdacl            = []
      $config            = '/etc/chrony.conf'
      $config_template   = 'chrony/chrony.conf.redhat.erb'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = chrony
      $config_keys_mode  = '0640'
      $service_name      = 'chronyd'
      $clientlog         = false
    }
    'Debian' : {
      $cmdacl            = []
      $config            = '/etc/chrony/chrony.conf'
      $config_template   = 'chrony/chrony.conf.debian.erb'
      $config_keys       = '/etc/chrony/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0640'
      $service_name      = 'chrony'
      $clientlog         = false
    }

    default     : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $config_keys_template = 'chrony/chrony.keys.erb'
  $package_name         = 'chrony'
  $servers              = {
    '0.pool.ntp.org' => ['iburst'],
    '1.pool.ntp.org' => ['iburst'],
    '2.pool.ntp.org' => ['iburst'],
    '3.pool.ntp.org' => ['iburst'],
  }
  $pools                = {}
  $makestep_seconds = 10
  $makestep_updates = 3
  $bindcmdaddress = ['127.0.0.1', '::1']
}
