class chrony (
        $ntpservers            = [ '0.nl.pool.ntp.org',
                                   '1.nl.pool.ntp.org',
                                   '2.nl.pool.ntp.org',
                                   '3.nl.pool.ntp.org', ]
){
    package { 'chrony':
        ensure => present,
    }

    file { '/etc/chrony.conf':
        ensure   => present,
        owner    => root,
        group    => root,
        mode     => 0644,
        content  => template('chrony/chrony.conf.erb'),
        require  => Package['chrony'],
        notify   => Service['chrony.service'],
    }

    service { 'chrony.service':
        provider   => systemd,
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
        require    => Package['chrony'],
     }
}
