if fact('os.family') == 'redhat' {
  file { '/var/run/chrony':
    ensure => directory,
  }
}
if fact('os.family') == 'Archlinux' {
  file { '/etc/sysconfig':
    ensure => directory,
  }
}


# Ubuntu 26.04 ships chrony.service with
# ConditionVirtualization=|!container / |wsl, so systemd refuses to ever
# start the unit inside a container-based acceptance node -- unrelated to
# anything Puppet manages. This is a deliberate upstream Ubuntu decision,
# not a module bug, so the workaround is confined to the test harness
# rather than shipped in manifests/. See
# https://github.com/voxpupuli/puppet-chrony/pull/254#issuecomment-5308411879
# if Ubuntu fixes this upstream like Debian, this can be removed

if fact('os.name') == 'Ubuntu' and fact('os.release.major') == '26.04' {
  file { '/etc/systemd/system/chrony.service.d':
    ensure => directory,
  }

  file { '/etc/systemd/system/chrony.service.d/override.conf':
    ensure  => file,
    content => "[Unit]\nConditionVirtualization=\n",
    require => File['/etc/systemd/system/chrony.service.d'],
    notify  => Exec['chrony-systemd-daemon-reload'],
  }

  exec { 'chrony-systemd-daemon-reload':
    command     => '/usr/bin/systemctl daemon-reload',
    refreshonly => true,
    path        => ['/usr/bin', '/bin'],
  }
}
