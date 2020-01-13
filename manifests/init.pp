# @summary Installs and configures chrony
#
# @example Install chrony with default options
#   include chrony
# @example Use specific servers
#   class { 'chrony':
#     servers => [ 'ntp1.corp.com', 'ntp2.corp.com', ],
#   }
# @example Ensure a secret password is used for chronyc
#   class { 'chrony':
#     servers         => [ 'ntp1.corp.com', 'ntp2.corp.com', ],
#     chrony_password => 'secret_password',
#   }
# @example Use NTP authentication
#   class { 'chrony':
#     keys            => [
#       '25 SHA1 HEX:1dc764e0791b11fa67efc7ecbc4b0d73f68a070c',
#     ],
#     servers         => {
#       'ntp1.corp.com' => ['key 25', 'iburst'],
#       'ntp2.corp.com' => ['key 25', 'iburst'],
#     },
#   }
# @example Have chronyd autogenerate a command key at startup
#   class { 'chrony':
#     chrony_password    => 'unset',
#     config_keys_manage => false,
#   }
# @example Allow some hosts
#   class { 'chrony':
#     queryhosts => ['192.168/16'],
#     port       => 123,
#   }
# @example Configure the leap second mode
#   class { 'chrony':
#     leapsecmode => 'slew',
#     smoothtime  => '400 0.001 leaponly',
#     maxslewrate => 1000.0
#   }
# @example Configure [makestep](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#makestep)
#   # Step the system clock if the adjustment is larger than 1000 seconds, but only in the first ten clock updates.
#   class { 'chrony':
#     makestep_seconds => 1000,
#     makestep_updates => 10,
#   }
#
# @see https://chrony.tuxfamily.org
#
# @param bindcmdaddress
#   Array of addresses of interfaces on which chronyd will listen for monitoring command packets (defaults to localhost).
# @param cmdacl
#   An array of ACLs for monitoring access. This expects a list of directives, for
#   example: `['cmdallow 1.2.3.4', 'cmddeny 1.2.3']`. The order will be respected at
#   the time of generating the configuration. The argument of the allow or deny
#   commands can be an address, a partial address or a subnet (see manpage for more
#   details).
# @param cmdport
#   The cmdport directive allows the port that is used for run-time monitoring (via the chronyc program)
#   to be altered from its default (323).
# @param commandkey
#   This sets the key ID used by chronyc to authenticate to chronyd.
# @param chrony_password
#   This sets the chrony password to be used in the key file.
#   By default a short fixed string is used. If set explicitly to
#   'unset' then no password will be added to the keys file by puppet.
# @param config
#   This sets the file to write chrony configuration into.
# @param config_template
#   This determines which template puppet should use for the chrony configuration.
# @param config_keys
#   This sets the file to write chrony keys into.
# @param config_keys_template
#   This determines which template puppet should use for the chrony key file.
# @param config_keys_owner
#   Specify unix owner of chrony keys file, defaults to 0.
# @param config_keys_group
#   Specify unix group of chrony keys files, defaults to 0 on ArchLinux and chrony on Redhat.
# @param config_keys_mode
#   Specify unix mode of chrony keys files, defaults to 0644 on ArchLinux and 0640 on Redhat.
# @param keys
#   An array of key lines.  These are printed as-is into the chrony key file.
# @param local_stratum
#   Override the stratum of the server which will be reported to clients
#   when the local reference is active. Defaults to 10.
# @param stratumweight
#   Sets how much distance should be added per stratum to the synchronisation distance when chronyd
#   selects the synchronisation source from available sources.
#   When not set, chronyd's default will be used, which since version 2.0 of chrony, is 0.001 seconds.
# @param log_options
#   Specify which information is to be logged.
# @param package_ensure
#   This can be set to 'present' or 'latest' or a specific version to choose the
#   chrony package to be installed.
# @param package_name
#   This determines the name of the package to install.
# @param peers
#   This selects the servers to use for NTP peers (symmetric association).
#   It is an array of servers.
# @param servers
#   This selects the servers to use for NTP servers.  It can be an array of servers
#   or a hash of servers to their respective options.
# @param refclocks
#   This should be a Hash of hardware reference clock drivers to use.  They hash
#   can either list a single list of options for the driver, or any array of
#   multiple options if the same driver is used for multiple hardware clocks.
#
#   Example:
#   ```puppet
#   refclocks => { 'PPS' => [ '/dev/pps0 lock NMEA refid GPS',
#                            '/dev/pps1:clear refid GPS2' ],
#                  'SHM' => '0 offset 0.5 delay 0.2 refid NMEA noselect' }
#   ```
# @param makestep_seconds
#   Configures the [`makestep`](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#makestep) `threshold`.
#   Normally chronyd will cause the system to gradually correct any time offset, by slowing down or speeding up the clock as required.
#   If the adjustment is larger than `makestep_seconds`, chronyd will step the clock.
#   Also see [`makestep_updates`](#makestep_updates). (Defaults to 10).
# @param makestep_updates
#   Configures the [`makestep`](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#makestep) `limit`.
#   Chronyd will step the time only if there have been no more than `makestep_updates` clock updates.
#   Set to a negative value to disable the limit (useful for virtual machines and laptops that may get suspended for a prolonged time).
#   Also see [`makestep_seconds`](#makestep_seconds). (Defaults to 3).
# @param queryhosts
#   This adds the networks, hosts that are allowed to query the daemon.
#   Note that `port` needs to be set for this to work.
# @param port
#   Port the service should listen on, to be used in combination with `queryhosts`.
#   Module default is `0` to prevent accidental activation of server mode.
# @param service_enable
#   This determines if the service should be enabled at boot.
# @param service_ensure
#   This determines if the service should be running or not.
# @param service_manage
#   This selects if puppet should manage the service in the first place.
# @param service_name
#   This selects the name of the chrony service for puppet to manage.
# @param smoothtime
#   Specify the smoothing of the time parameter as a string, for example `smoothtime 50000 0.01`.
# @param mailonchange
#   Specify the mail you wanna alert when chronyd executes a sync grater than the `threshold`.
# @param threshold
#   Specify the time limit for triggering events.
# @param lock_all
#   Force chrony to only use RAM & prevent swapping.
# @param leapsecmode
#   Configures how to insert the leap second mode.
# @param maxslewrate
#   Maximum rate for chronyd to slew the time. Only float type values possible, for example: `maxslewrate 1000.0`.
class chrony (
  Array[String] $bindcmdaddress                                    = $chrony::params::bindcmdaddress,
  Array[String] $cmdacl                                            = $chrony::params::cmdacl,
  $cmdport                                                         = $chrony::params::cmdport,
  $commandkey                                                      = $chrony::params::commandkey,
  $config                                                          = $chrony::params::config,
  $config_template                                                 = $chrony::params::config_template,
  $config_keys                                                     = $chrony::params::config_keys,
  $config_keys_template                                            = $chrony::params::config_keys_template,
  $chrony_password                                                 = $chrony::params::chrony_password,
  $config_keys_owner                                               = $chrony::params::config_keys_owner,
  $config_keys_group                                               = $chrony::params::config_keys_group,
  $config_keys_mode                                                = $chrony::params::config_keys_mode,
  $config_keys_manage                                              = $chrony::params::config_keys_manage,
  $keys                                                            = $chrony::params::keys,
  $local_stratum                                                   = $chrony::params::local_stratum,
  $log_options                                                     = $chrony::params::log_options,
  $package_ensure                                                  = $chrony::params::package_ensure,
  $package_name                                                    = $chrony::params::package_name,
  Optional[String] $package_source                                 = $chrony::params::package_source,
  Optional[String] $package_provider                               = $chrony::params::package_provider,
  $refclocks                                                       = $chrony::params::refclocks,
  $peers                                                           = $chrony::params::peers,
  $servers                                                         = $chrony::params::servers,
  $pools                                                           = $chrony::params::pools,
  Numeric $makestep_seconds                                        = $chrony::params::makestep_seconds,
  Integer $makestep_updates                                        = $chrony::params::makestep_updates,
  $queryhosts                                                      = $chrony::params::queryhosts,
  $mailonchange                                                    = $chrony::params::mailonchange,
  Float $threshold                                                 = $chrony::params::threshold,
  Boolean $lock_all                                                = $chrony::params::lock_all,
  $port                                                            = $chrony::params::port,
  Boolean $clientlog                                               = $chrony::params::clientlog,
  Optional[Integer] $clientloglimit                                = $chrony::params::clientloglimit,
  $service_enable                                                  = $chrony::params::service_enable,
  $service_ensure                                                  = $chrony::params::service_ensure,
  $service_manage                                                  = $chrony::params::service_manage,
  $service_name                                                    = $chrony::params::service_name,
  Optional[String] $smoothtime                                     = $chrony::params::smoothtime,
  Optional[Enum['system', 'step', 'slew', 'ignore']] $leapsecmode  = $chrony::params::leapsecmode,
  Optional[Float] $maxslewrate                                     = $chrony::params::maxslewrate,
  Optional[Numeric] $stratumweight                                 = $chrony::params::stratumweight,
) inherits chrony::params {

  if ! $config_keys_manage and $chrony_password != 'unset'  {
    fail("Setting \$config_keys_manage false and \$chrony_password at same time in ${module_name} is not possible.")
  }

  if $queryhosts != [] and $port == 0 {
    fail("Setting \$queryhosts has no effect unless also setting \$port which defaults to 0 in ${module_name}, refusing that.")
  }

  contain 'chrony::install'
  contain 'chrony::config'
  contain 'chrony::service'

  Class['chrony::install']
  -> Class['chrony::config']
  ~> Class['chrony::service']
}
