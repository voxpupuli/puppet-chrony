# @summary chrony class parameters
#
# @api private
class chrony::params {
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
}
