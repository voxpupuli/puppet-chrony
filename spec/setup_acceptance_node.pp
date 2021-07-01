if fact('os.family') == 'redhat' {
  file { '/var/run/chrony':
    ensure => directory,
  }
}
