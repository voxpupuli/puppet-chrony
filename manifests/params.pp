# @summary chrony class parameters
#
# @api private
class chrony::params {
  case $facts['os']['family'] {
    'Archlinux' : {
      $package_name      = 'chrony'
      $cmdacl            = ['cmdallow 127.0.0.1']
      $config            = '/etc/chrony.conf'
      $config_keys       = '/etc/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $service_name      = 'chronyd'
      $wait_manage       = false
      $clientlog         = true
      $rtconutc          = true
      $dumpdir           = '/var/lib/chrony'
    }
    'Gentoo' : {
      $package_name      = 'net-misc/chrony'
      $cmdacl            = []
      $config            = '/etc/chrony/chrony.conf'
      $config_keys       = '/etc/chrony/chrony.keys'
      $config_keys_owner = 0
      $config_keys_group = 0
      $config_keys_mode  = '0644'
      $service_name      = 'chronyd'
      $wait_manage       = false
      $clientlog         = true
      $rtconutc          = true
      $dumpdir           = undef
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
      $wait_manage       = true
      $clientlog         = false
      $rtconutc          = false
      $dumpdir           = undef
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
      $wait_manage       = false
      $clientlog         = false
      $rtconutc          = false
      $dumpdir           = undef
    }

    default     : {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} based system.")
    }
  }
}
