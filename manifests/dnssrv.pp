# @summary Manages a chrony DNS Service record for dynamic NTP configuration
#
# Enables the `chrony-dnssrv@.timer` unit shipped with the chrony package, which
# periodically resolves the record with `dig` and feeds the servers to a running
# chronyd over chronyc.
#
# @example Enable a DNS Service record
#   chrony::dnssrv { '_ntp._udp.example.com': }
#
# @example Explicitly set the SRV record
#   chrony::dnssrv { 'example-ntp':
#     srv_record => '_ntp._udp.example.com',
#   }
#
# @example Remove a DNS Service record
#   chrony::dnssrv { '_ntp._udp.example.com':
#     ensure => absent,
#   }
#
# @param srv_record
#   The DNS Service record to query.
#
# @param ensure
#   Whether the DNS SRV record should be enabled or disabled.
#
define chrony::dnssrv (
  Enum['present', 'absent'] $ensure = 'present',
  Chrony::Srvrecord $srv_record     = $title,
) {
  if $facts['os']['family'] in ['Archlinux', 'Gentoo'] {
    fail("${module_name}::dnssrv needs chrony-helper, which ${facts['os']['family']} does not package.")
  }

  # systemd escapes the instance name itself, so pass the record unmodified
  service { "chrony-dnssrv@${srv_record}.timer":
    ensure => stdlib::ensure($ensure, 'service'),
    enable => $ensure == 'present',
  }
}
