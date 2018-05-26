class chrony::params {
  $commandkey         = 0
  $keys               = []
  $package_ensure     = 'present'
  $refclocks          = []
  $service_enable     = true
  $service_ensure     = 'running'
  $service_manage     = true
  $chrony_password    = 'xyzzy'
  $queryhosts         = []
  $port               = 0
  $config_keys_manage = true
  $mailonchange       = undef
  $threshold          = 0.5
  $lock_all           = false

  case $::osfamily {
    'Archlinux' : {
      $config            = '/etc/chrony.conf'
      $config_template   = 'chrony/chrony.conf.archlinux.erb'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $service_name      = 'chrony'
    }
    'RedHat' : {
      $config            = '/etc/chrony.conf'
      $config_template   = 'chrony/chrony.conf.redhat.erb'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = chrony
      $config_keys_mode  = '0640'
      $service_name      = 'chronyd'
    }
    'Debian' : {
      $config            = '/etc/chrony/chrony.conf'
      $config_template   = 'chrony/chrony.conf.debian.erb'
      $config_keys       = '/etc/chrony/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0640'
      $service_name      = 'chrony'
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

}
