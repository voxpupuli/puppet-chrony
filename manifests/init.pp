# @summary Installs and configures chrony
#
# @example Install chrony with default options
#   include chrony
# @example Use specific servers (These will be configured with the `iburst` option.)
#   class { 'chrony':
#     servers => [ 'ntp1.corp.com', 'ntp2.corp.com', ],
#   }
# @example Two specific servers without `iburst`
#   class { 'chrony':
#     servers => {
#       'ntp1.corp.com' => [],
#       'ntp2.corp.com' => [],
#     },
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
# @param bindaddress
#   Array of addresses of interfaces on which chronyd will listen for NTP traffic.
#   Listens on all addresses if left empty.
# @param bindcmdaddress
#   Array of addresses of interfaces on which chronyd will listen for monitoring command packets.
# @param initstepslew
#   Allow chronyd to make a rapid measurement of the system clock error at boot time,
#   and to correct the system clock by stepping before normal operation begins.
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
# @param config_keys_manage
#   Determines whether puppet will manage the content of the keys file after it has been created for the first time.
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
# @param driftfile
#   A file for chrony to record clock drift in.
# @param local_stratum
#   Override the stratum of the server which will be reported to clients
#   when the local reference is active. Use `false` to not set local_stratum in
#   chrony configuration.
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
# @param package_source
#   Source for the package when not wanting to install from a package repository.  This is required if
#   [`package_provider`](#package_provider) is set to `rpm` or `dpkg`.
# @param package_provider
#   Override the default package provider with a specific backend to use when installing the chrony package.
#   Also see [`package_source`](#package_source).
# @param peers
#   This selects the servers to use for NTP peers (symmetric association).
#   It can be an array of peers or a hash of peers with their respective options.
# @param servers
#   This selects the servers to use for NTP servers.  It can be an array of servers
#   or a hash of servers to their respective options. If an array is used, `iburst` will be configured for each server.
#   If you don't want to use `iburst`, use a hash instead.
# @param pools
#   This is used to specify one or more *pools* of NTP servers to use instead of individual NTP servers.
#   Similar to [`server`](#server), it can be an array of pools, (using iburst), or a hash of pools to their respective options.
#   See [pool](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#pool)
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
#   Also see [`makestep_updates`](#makestep_updates).
# @param makestep_updates
#   Configures the [`makestep`](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#makestep) `limit`.
#   Chronyd will step the time only if there have been no more than `makestep_updates` clock updates.
#   Set to a negative value to disable the limit (useful for virtual machines and laptops that may get suspended for a prolonged time).
#   Also see [`makestep_seconds`](#makestep_seconds).
# @param queryhosts
#   This adds the networks, hosts that are allowed to query the daemon.
# @param port
#   Port the service should listen on. Module default is `undef` which means that port
#   isn't added to chrony.conf, and chrony listens to the default ntp port 123 if
#   `queryhosts` is used.
# @param service_enable
#   This determines if the service should be enabled at boot.
# @param service_ensure
#   This determines if the service should be running or not.
# @param service_manage
#   This selects if puppet should manage the service in the first place.
# @param service_name
#   This selects the name of the chrony service for puppet to manage.
# @param wait_enable
#   This determines if the chrony-wait service should be enabled at boot.
# @param wait_ensure
#   This determines if the chrony-wait service should be running or not.
# @param wait_manage
#   This selects if puppet should manage the chrony-wait service in the first place.
# @param wait_name
#   This selects the name of the chrony-wait service for puppet to manage.
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
# @param leapsectz
#   Specifies a timezone that chronyd can use to determine the offset between UTC and TAI.
# @param maxdistance
#   Sets the maximum root distance of a source to be acceptable for synchronisation of the clock.
# @param maxslewrate
#   Maximum rate for chronyd to slew the time. Only float type values possible, for example: `maxslewrate 1000.0`.
# @param clientlog
#   Determines whether to log client accesses.
# @param clientloglimit
#   When set, specifies the maximum amount of memory in bytes that chronyd is allowed to allocate for logging of client accesses.
#   If not set, chrony's, default will be used. In modern versions this is 524288 bytes.  Older versions defaulted to have no limit.
#   See [clientloglimit](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#clientloglimit)
# @param rtcsync
#  Sync system clock to RTC periodically
# @param rtconutc
#   Keep RTC in UTC instead of local time.
#   If not set, chrony's, default will be used. On Arch Linux the default is true instead.
#   See [rtconutc](https://chrony.tuxfamily.org/doc/3.4/chrony.conf.html#rtconutc)
# @param hwtimestamps
#   This selects interfaces to enable hardware timestamps on. It can be an array of
#   interfaces or a hash of interfaces to their respective options.
# @param dumpdir
#   Directory to store measurement history in on exit.
class chrony (
  Array[Stdlib::IP::Address] $bindaddress                          = [],
  Array[String] $bindcmdaddress                                    = ['127.0.0.1', '::1'],
  Optional[String] $initstepslew                                   = undef,
  Array[String] $cmdacl                                            = $chrony::params::cmdacl,
  Optional[Stdlib::Port] $cmdport                                  = undef,
  $commandkey                                                      = 0,
  Stdlib::Unixpath $config                                         = $chrony::params::config,
  String[1] $config_template                                       = 'chrony/chrony.conf.epp',
  Stdlib::Unixpath $config_keys                                    = $chrony::params::config_keys,
  String[1] $config_keys_template                                  = 'chrony/chrony.keys.epp',
  String[1] $chrony_password                                       = 'xyzzy',
  Variant[Integer[0],String[1]] $config_keys_owner                 = $chrony::params::config_keys_owner,
  Variant[Integer[0],String[1]] $config_keys_group                 = $chrony::params::config_keys_group,
  Stdlib::Filemode $config_keys_mode                               = $chrony::params::config_keys_mode,
  Boolean $config_keys_manage                                      = true,
  Array[String[1]] $keys                                           = [],
  Stdlib::Unixpath $driftfile                                      = '/var/lib/chrony/drift',
  Variant[Boolean[false],Integer[1,15]] $local_stratum             = 10,
  Optional[String[1]] $log_options                                 = undef,
  String[1] $package_ensure                                        = 'present',
  String[1] $package_name                                          = $chrony::params::package_name,
  Optional[String] $package_source                                 = undef,
  Optional[String] $package_provider                               = undef,
  $refclocks                                                       = [],
  Chrony::Servers $peers                                           = [],
  Chrony::Servers $servers                                         = {
    '0.pool.ntp.org' => ['iburst'],
    '1.pool.ntp.org' => ['iburst'],
    '2.pool.ntp.org' => ['iburst'],
    '3.pool.ntp.org' => ['iburst'],
  },
  Chrony::Servers $pools                                           = {},
  Numeric $makestep_seconds                                        = 10,
  Integer $makestep_updates                                        = 3,
  Array[String] $queryhosts                                        = [],
  Optional[String[1]] $mailonchange                                = undef,
  Float $threshold                                                 = 0.5,
  Boolean $lock_all                                                = false,
  Optional[Stdlib::Port] $port                                     = undef,
  Boolean $clientlog                                               = $chrony::params::clientlog,
  Optional[Integer] $clientloglimit                                = undef,
  Boolean $service_enable                                          = true,
  Stdlib::Ensure::Service $service_ensure                          = 'running',
  Boolean $service_manage                                          = true,
  String[1] $service_name                                          = $chrony::params::service_name,
  Boolean $wait_enable                                             = false,
  Stdlib::Ensure::Service $wait_ensure                             = 'stopped',
  Boolean $wait_manage                                             = $chrony::params::wait_manage,
  String[1] $wait_name                                             = 'chrony-wait.service',
  Optional[String] $smoothtime                                     = undef,
  Optional[Enum['system', 'step', 'slew', 'ignore']] $leapsecmode  = undef,
  Optional[String] $leapsectz                                      = undef,
  Optional[Float] $maxdistance                                     = undef,
  Optional[Float] $maxslewrate                                     = undef,
  Optional[Float] $maxupdateskew                                   = undef,
  Optional[Numeric] $stratumweight                                 = undef,
  Boolean $rtcsync                                                 = true,
  Boolean $rtconutc                                                = $chrony::params::rtconutc,
  Variant[Hash,Array[String]] $hwtimestamps                        = [],
  Optional[Stdlib::Unixpath] $dumpdir                              = $chrony::params::dumpdir,
) inherits chrony::params {
  if ! $config_keys_manage and $chrony_password != 'unset' {
    fail("Setting \$config_keys_manage false and \$chrony_password at same time in ${module_name} is not possible.")
  }

  contain 'chrony::install'
  contain 'chrony::config'
  contain 'chrony::service'

  Class['chrony::install']
  -> Class['chrony::config']
  ~> Class['chrony::service']
}
