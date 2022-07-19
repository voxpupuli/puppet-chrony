# frozen_string_literal: true

require 'spec_helper'

describe 'chrony' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let(:config_file) do
        case facts[:osfamily]
        when 'Archlinux', 'RedHat', 'Suse'
          '/etc/chrony.conf'
        else
          '/etc/chrony/chrony.conf'
        end
      end
      let(:keys_file) do
        case facts[:osfamily]
        when 'Archlinux', 'RedHat', 'Suse'
          '/etc/chrony.keys'
        else
          '/etc/chrony/chrony.keys'
        end
      end
      let(:config_file_contents) do
        catalogue.resource('file', config_file).send(:parameters)[:content]
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('chrony') }
        it { is_expected.to contain_class('chrony::install').that_comes_before('Class[chrony::config]') }
        it { is_expected.to contain_class('chrony::config').that_notifies('Class[chrony::service]') }
        it { is_expected.to contain_class('chrony::service') }
      end

      context 'chrony::package' do
        context 'using defaults' do
          it { is_expected.to contain_package('chrony').with_ensure('present') }
        end
      end

      context 'chrony::config' do
        case facts[:os]['family']
        when 'Archlinux'
          context 'using defaults' do
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 127\.0\.0\.1$}) }

            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*rtconutc$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*driftfile /var/lib/chrony/drift$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*rtcsync$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*dumpdir /var/lib/chrony$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*ntpsigndsocket}) }
            it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*\n\s*$}) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0644') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_group('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_content(sensitive("0 xyzzy\n")) }
          end
        when 'Gentoo'
          context 'using defaults' do
            it do
              is_expected.to contain_file('/etc/chrony/chrony.conf').
                without_content(%r{^\s*cmdallow}).
                with_content(%r{^\s*server 0.pool.ntp.org iburst$}).
                with_content(%r{^\s*server 1.pool.ntp.org iburst$}).
                with_content(%r{^\s*server 2.pool.ntp.org iburst$}).
                with_content(%r{^\s*server 3.pool.ntp.org iburst$}).
                with_content(%r{^\s*rtconutc$}).
                with_content(%r{^\s*driftfile /var/lib/chrony/drift$}).
                with_content(%r{^\s*rtcsync$}).
                without_content(%r{^\s*dumpdir}).
                without_content(%r{^\s*ntpsigndsocket}).
                without_content(%r{^\s*\n\s*$})
            end

            it do
              is_expected.to contain_file('/etc/chrony/chrony.keys').
                with_mode('0644').
                with_owner('0').
                with_group('0').
                with_replace(true).
                with_content(sensitive("0 xyzzy\n"))
            end
          end
        when 'RedHat'
          context 'using defaults' do
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress ::1$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$}) }
            it { is_expected.not_to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow.*$}) }

            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*driftfile /var/lib/chrony/drift$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*rtcsync$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*dumpdir}) }
            it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*ntpsigndsocket}) }
            it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*\n\s*$}) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0640') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_group('chrony') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_content(sensitive("0 xyzzy\n")) }
          end
        when 'Debian'
          context 'using defaults' do
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress ::1$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$}) }
            it { is_expected.not_to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow.*$}) }

            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*driftfile /var/lib/chrony/drift$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*rtcsync$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').without_content(%r{^\s*dumpdir}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').without_content(%r{^\s*ntpsigndsocket}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').without_content(%r{^\s*\n\s*$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_mode('0640') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_group('0') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content(sensitive("0 xyzzy\n")) }
          end
        end
        it { is_expected.to contain_file(config_file).with_content(%r{keyfile .*chrony.keys}) }
      end

      context 'with empty config_keys' do
        let :params do
          {
            config_keys: ''
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_file(config_file).without_content(%r{keyfile .*chrony.keys}) }
        it { is_expected.not_to contain_file(keys_file) }
      end

      context 'with some params passed in' do
        let(:params) do
          {
            queryhosts: ['192.168/16'],
            denyqueryhosts: ['10.0/16'],
            port: 123,
            cmdport: 257,
            config_keys_mode: '0123',
            config_keys_owner: 'steve',
            config_keys_group: 'mrt',
            config_keys_manage: true,
            confdir: '/tmp/chroconf',
            sourcedir: '/tmp/chrosources',
            chrony_password: sensitive('sunny'),
            bindaddress: ['10.0.0.1', '::1'],
            bindcmdaddress: ['10.0.0.1'],
            initstepslew: '600',
            cmdacl: ['cmdallow 1.2.3.4', 'cmddeny 1.2.3', 'cmdallow all 1.2'],
            leapsecmode: 'slew',
            leapsectz: 'right/UTC',
            log_options: 'statistics refclocks',
            logbanner: 40,
            logchange: 4.0,
            maxdistance: 16.0,
            maxslewrate: 1000.0,
            maxupdateskew: 1000.0,
            smoothtime: '400 0.001 leaponly',
            rtconutc: true,
            hwtimestamps: ['eth0'],
            driftfile: '/var/tmp/chrony.drift',
            rtcsync: false,
            sched_priority: 1,
            dumpdir: '/var/tmp',
            ntpsigndsocket: '/var/lib/samba/ntp_signd/socket',
            ntsserverkey: '/tmp/cert.key',
            ntsservercert: '/tmp/cert.pem',
            ntsport: 12,
            maxntsconnections: 32,
            minsources: 22,
            minsamples: 33,
            acquisitionport: 321,
            ntsprocesses: 5,
            ntsdumpdir: '/tmp/ntsdump',
            ntsntpserver: 'foo.bar',
            ntsrotate: 8
          }
        end

        context 'chrony::config' do
          case facts[:os]['family']
          when 'Archlinux'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*allow 192\.168/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*deny 10\.0/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*rtconutc$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*acquisitionport 321$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*hwtimestamp eth0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*driftfile /var/tmp/chrony.drift$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*rtcsync$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*dumpdir /var/tmp$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntpsigndsocket /var/lib/samba/ntp_signd/socket$}) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content(sensitive("0 sunny\n")) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxdistance 16\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxupdateskew 1000\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsserverkey /tmp/cert.key$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsservercert /tmp/cert.pem$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsport 12$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxntsconnections 32$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsprocesses 5$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsdumpdir /tmp/ntsdump$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsntpserver foo.bar$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsrotate 8$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*confdir /tmp/chroconf$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*sourcedir /tmp/chrosources$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*log statistics refclocks$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*logbanner 40$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*logchange 4\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*minsources 22$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*minsamples 33$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*sched_priority 1$}) }
            end
          when 'RedHat'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*leapsecmode slew$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*leapsectz right/UTC$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxdistance 16\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxslewrate 1000\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxupdateskew 1000\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*smoothtime 400 0\.001 leaponly$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdport 257$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*acquisitionport 321$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*allow 192\.168/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*deny 10\.0/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindaddress ::1$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*initstepslew 600$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*rtconutc$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*hwtimestamp eth0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*driftfile /var/tmp/chrony.drift$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').without_content(%r{^\s*rtcsync$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*dumpdir /var/tmp$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntpsigndsocket /var/lib/samba/ntp_signd/socket$}) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content(sensitive("0 sunny\n")) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsserverkey /tmp/cert.key$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsservercert /tmp/cert.pem$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsport 12$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*maxntsconnections 32$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsprocesses 5$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsdumpdir /tmp/ntsdump$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsntpserver foo.bar$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*ntsrotate 8$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*confdir /tmp/chroconf$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*sourcedir /tmp/chrosources$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*log statistics refclocks$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*logbanner 40$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*logchange 4\.0$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*sched_priority 1$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*minsources 22$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*minsamples 33$}) }
            end
          when 'Debian', 'Gentoo'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*leapsectz right/UTC$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*leapsecmode slew$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*maxdistance 16\.0$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*maxslewrate 1000\.0$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*maxupdateskew 1000\.0$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*smoothtime 400 0\.001 leaponly$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdport 257$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*acquisitionport 321$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^s*allow 192\.168/16$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^s*deny 10\.0/16$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindaddress ::1$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*initstepslew 600$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*rtconutc$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*hwtimestamp eth0$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*driftfile /var/tmp/chrony.drift$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').without_content(%r{^\s*rtcsync$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*dumpdir /var/tmp$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntpsigndsocket /var/lib/samba/ntp_signd/socket$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content(sensitive("0 sunny\n")) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsserverkey /tmp/cert.key$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsservercert /tmp/cert.pem$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsport 12$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*maxntsconnections 32$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsprocesses 5$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsdumpdir /tmp/ntsdump$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsntpserver foo.bar$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*ntsrotate 8$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*confdir /tmp/chroconf$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*sourcedir /tmp/chrosources$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*log statistics refclocks$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*logbanner 40$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*logchange 4\.0$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*sched_priority 1$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*minsources 22$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*minsamples 33$}) }
            end
          end
        end
      end

      describe 'stratumweight' do
        context 'by default' do
          case facts[:os]['family']
          when 'Archlinux', 'RedHat'
            it { is_expected.not_to contain_file('/etc/chrony.conf').with_content(%r{stratumweight}) }
          when 'Debian', 'Gentoo'
            it { is_expected.not_to contain_file('/etc/chrony/chrony.conf').with_content(%r{stratumweight}) }
          end
        end

        context 'when set' do
          let(:params) do
            {
              stratumweight: 0
            }
          end

          case facts[:os]['family']
          when 'Archlinux', 'RedHat'
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^stratumweight 0$}) }
          when 'Debian', 'Gentoo'
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^stratumweight 0$}) }
          end
        end
      end

      describe 'servers' do
        context 'by default' do
          it do
            expected_lines = [
              'server 0.pool.ntp.org iburst',
              'server 1.pool.ntp.org iburst',
              'server 2.pool.ntp.org iburst',
              'server 3.pool.ntp.org iburst'
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end

        context 'when servers is an array' do
          let(:params) do
            {
              servers: ['ntp1.corp.com', 'ntp2.corp.com'],
            }
          end

          it do
            expected_lines = [
              'server ntp1.corp.com iburst',
              'server ntp2.corp.com iburst',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end

        context 'when servers is an (unsorted) hash' do
          let(:params) do
            {
              servers: {
                'ntp3.corp.com' => [],
                'ntp1.corp.com' => ['key 25', 'iburst'],
                'ntp4.corp.com' => :undef,
                'ntp2.corp.com' => ['key 25', 'iburst'],
              }
            }
          end

          it do
            expected_lines = [
              'server ntp1.corp.com key 25 iburst',
              'server ntp2.corp.com key 25 iburst',
              'server ntp3.corp.com',
              'server ntp4.corp.com',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end
      end

      describe 'pools' do
        context 'by default' do
          it { expect(config_file_contents).not_to match(%r{^pool}) }
        end

        context 'when pools is an array' do
          let(:params) do
            {
              pools: ['0.pool.ntp.org', '1.pool.ntp.org']
            }
          end

          it do
            expected_lines = [
              'server 0.pool.ntp.org iburst',
              'server 1.pool.ntp.org iburst',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end

        context 'when pools is a hash' do
          let(:params) do
            {
              pools: {
                '3.pool.ntp.org' => [],
                '0.pool.ntp.org' => ['maxsources 4'],
                '1.pool.ntp.org' => ['maxsources 4'],
                '2.pool.ntp.org' => ['maxsources 4'],
              }
            }
          end

          it do
            expected_lines = [
              'pool 0.pool.ntp.org maxsources 4',
              'pool 1.pool.ntp.org maxsources 4',
              'pool 2.pool.ntp.org maxsources 4',
              'pool 3.pool.ntp.org',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end
      end

      describe 'peers' do
        context 'by default' do
          it { expect(config_file_contents).not_to match(%r{^peer}) }
        end

        context 'when peers is an array' do
          let(:params) do
            {
              peers: ['peer1.example.com', 'peer2.example.com']
            }
          end

          it do
            expected_lines = [
              'peer peer1.example.com',
              'peer peer2.example.com',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end

        context 'when peers is a hash' do
          let(:params) do
            {
              peers: {
                'peer1.example.com' => [],
                'peer2.example.com' => ['maxpoll 6'],
                'peer3.example.com' => :undef,
              }
            }
          end

          it do
            expected_lines = [
              'peer peer1.example.com',
              'peer peer2.example.com maxpoll 6',
              'peer peer3.example.com',
            ]
            expect(config_file_contents.split("\n") & expected_lines).to eq(expected_lines)
          end
        end
      end

      context 'unmanaged chrony.keys file' do
        let(:params) do
          {
            config_keys_manage: false,
            chrony_password: 'unset'
          }
        end

        context 'chrony::config' do
          case facts[:os]['family']
          when 'Archlinux', 'RedHat'
            context 'unmanaged chrony.keys file' do
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(false) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content(sensitive('')) }
            end
          when 'Debian', 'Gentoo'
            context 'unmanaged chrony.keys file' do
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(false) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content(sensitive('')) }
            end
          end
        end
      end

      context 'hwtimestamps as hash' do
        let(:params) do
          {
            hwtimestamps: { 'eth0' => ['minpoll 1', 'maxpoll 7'] }
          }
        end

        case facts[:os]['family']
        when 'Archlinux', 'Redhat'
          it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*hwtimestamp eth0 minpoll 1 maxpoll 7$}) }
        when 'Debian', 'Gentoo'
          it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*hwtimestamp eth0 minpoll 1 maxpoll 7$}) }
        end
      end

      context 'unmanaged chrony.keys file and password' do
        let(:params) do
          {
            config_keys_manage: false
          }
        end

        it { is_expected.to raise_error(%r{Setting \$config_keys_manage false and \$chrony_password at same time in chrony is not possible}) }
      end

      context 'chrony::service' do
        let(:params) do
          {
            service_ensure: 'running',
            service_enable: true,
            service_manage: true
          }
        end

        case facts[:os]['family']
        when 'RedHat', 'Suse', 'Archlinux'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chrony-wait.service').with(
                ensure: 'stopped',
                enable: false
              )
            end
          end
        else
          context 'using defaults' do
            it do
              is_expected.not_to contain_service('chrony-wait.service')
            end
          end
        end

        context 'using defaults' do
          it do
            is_expected.to contain_service('chronyd').with(
              ensure: 'running',
              enable: true
            )
          end
        end
      end

      context 'with wait_manage false' do
        let(:params) do
          { wait_manage: false }
        end

        it do
          is_expected.not_to contain_service('chrony-wait.service')
        end
      end

      context 'with wait_enable true' do
        let(:params) do
          { wait_enable: true }
        end

        case facts[:os]['family']
        when 'RedHat', 'Suse', 'Archlinux'
          it do
            is_expected.to contain_service('chrony-wait.service').with(
              ensure: 'stopped',
              enable: true
            )
          end
        else
          it do
            is_expected.not_to contain_service('chrony-wait.service')
          end
        end
      end

      context 'with wait_ensure running' do
        let(:params) do
          { wait_ensure: 'running' }
        end

        case facts[:os]['family']
        when 'RedHat', 'Suse', 'Archlinux'
          it do
            is_expected.to contain_service('chrony-wait.service').with(
              ensure: 'running',
              enable: false
            )
          end
        else
          it do
            is_expected.not_to contain_service('chrony-wait.service')
          end
        end
      end

      context 'disable local_stratum' do
        let(:params) do
          {
            local_stratum: false
          }
        end

        case facts[:os]['family']
        when 'Archlinux', 'Redhat'
          it { is_expected.not_to contain_file('/etc/chrony.conf').with_content(%r{^\s*local stratum}) }
        when 'Debian', 'Gentoo'
          it { is_expected.not_to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*local stratum}) }
        end
      end
    end
  end
end
