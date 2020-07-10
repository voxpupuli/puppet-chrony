# @summary chrony class parameters
#
# @api private
class chrony::params {
  case $::osfamily {
    'Archlinux' : {
      $package_name      = 'chrony'
      $cmdacl            = ['cmdallow 127.0.0.1']
      $config            = '/etc/chrony.conf'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $service_name      = 'chrony'
      $clientlog         = true
      $rtconutc          = true
    }
    'Suse', 'RedHat' : {
      $package_name      = 'chrony'
      $cmdacl            = []
      $config            = '/etc/chrony.conf'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = chrony
      $config_keys_mode  = '0640'
      $service_name      = 'chronyd'
      $clientlog         = false
      $rtconutc          = false
    }
    'Debian' : {
      $package_name      = 'chrony'
      $cmdacl            = []
      $config            = '/etc/chrony/chrony.conf'
      $config_keys       = '/etc/chrony/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0640'
      $service_name      = 'chrony'
      $clientlog         = false
      $rtconutc          = false
    }

    default     : {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
