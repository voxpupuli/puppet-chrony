# @summary Manages chrony DNS Service records for dynamic NTP configuration
#
# This defined type manages the configuration of DNS Service records for chrony using
# chrony's native sourcedir functionality. It uses a script to query DNS SRV records
# and writes the resolved servers to a .sources file that chrony can reload dynamically.
# Uses systemd timers for periodic DNS SRV record updates.
#
# @param srv_record
#   The DNS Service record to query (e.g., '_ntp._udp.example.com').
#
# @param ensure
#   Whether the DNS SRV record should be enabled or disabled.
#
# @param sourcedir
#   The directory where chrony sources files are stored.
#
# @param poll_interval
#   The polling interval for the NTP servers (as a power of 2).
#
# @param timer_oncalendar
#   The OnCalendar setting for the systemd timer.
#   See systemd.time(7) for valid values.
#
# @param timer_randomized_delay
#   The RandomizedDelaySec setting for the systemd timer.
#   Adds a random delay between 0 and the specified duration.
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
# @example Custom refresh interval (every hour)
#   chrony::dnssrv { '_ntp._udp.example.com':
#     timer_oncalendar => 'hourly',
#   }
#
define chrony::dnssrv (
  Enum['present', 'absent'] $ensure               = 'present',
  String[1] $srv_record                           = $title,
  Stdlib::Absolutepath $sourcedir                 = '/var/run/chrony-dnssrv',
  Integer[0, 24] $poll_interval                   = 6,
  String[1] $timer_oncalendar                     = '*:0/30',
  Optional[String[1]] $timer_randomized_delay     = undef,
) {
  # Sanitize the SRV record name for service/timer names (systemd doesn't like dots)
  $safe_name = regsubst($srv_record, '[^a-zA-Z0-9_-]', '_', 'G')
  # Use actual srv_record for filenames
  $sources_file = "${sourcedir}/${srv_record}.sources"
  $script_file = "${sourcedir}/${srv_record}.sh"

  file { $script_file:
    ensure  => stdlib::ensure($ensure, 'file'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => epp('chrony/dnssrv_update.sh.epp',
      {
        'srv_record'    => $srv_record,
        'sources_file'  => $sources_file,
        'poll_interval' => $poll_interval,
      }
    ),
  }

  # Initial population of the sources file
  if $ensure == 'present' {
    exec { "dnssrv-initial-${srv_record}":
      command => $script_file,
      path    => ['/usr/bin', '/bin'],
      creates => $sources_file,
      require => File[$script_file],
    }
  }

  # Ensure the sources file is removed when ensure => absent
  file { $sources_file:
    ensure => stdlib::ensure($ensure, 'file'),
  }

  $_timer_randomized_delay_line = $timer_randomized_delay ? {
    undef   => '',
    default => "RandomizedDelaySec=${timer_randomized_delay}\n",
  }

  $_timer_content = @("EOT")
    [Unit]
    Description=Update chrony DNS SRV records for ${srv_record}

    [Timer]
    OnCalendar=${timer_oncalendar}
    ${_timer_randomized_delay_line}Persistent=true

    [Install]
    WantedBy=timers.target
    | EOT

  $_service_content = @("EOT")
    [Unit]
    Description=Update chrony DNS SRV records for ${srv_record}

    [Service]
    Type=oneshot
    ExecStart=${script_file}
    | EOT

  systemd::timer { "chrony-dnssrv-${safe_name}.timer":
    timer_content   => $_timer_content,
    service_content => $_service_content,
    active          => $ensure == 'present',
    enable          => $ensure == 'present',
  }
}
