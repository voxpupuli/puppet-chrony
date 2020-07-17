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

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('chrony') }
        it { is_expected.to contain_class('chrony::params') }
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
        case facts[:osfamily]
        when 'Archlinux'
          context 'using defaults' do
            it do
              is_expected.to contain_file(config_file)
                .with_content(%r{^\s*cmdallow 127\.0\.0\.1$})
                .with_content(%r{^\s*server 0.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 1.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 2.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 3.pool.ntp.org iburst$})
                .with_content(%r{^\s*rtconutc$})
                .with_content(%r{^\s*driftfile /var/lib/chrony/drift$})
                .with_content(%r{^\s*rtcsync$})
                .with_content(%r{^\s*dumpdir /var/lib/chrony$})
                .without_content(%r{^\s*\n\s*$})
            end
            it do
              is_expected.to contain_file(keys_file)
                .with_mode('0644')
                .with_owner('0')
                .with_group('0')
                .with_replace(true)
                .with_content("0 xyzzy\n")
            end
          end
        when 'Gentoo'
          context 'using defaults' do
            it do
              is_expected.to contain_file(config_file)
                .without_content(%r{^\s*cmdallow})
                .with_content(%r{^\s*server 0.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 1.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 2.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 3.pool.ntp.org iburst$})
                .with_content(%r{^\s*rtconutc$})
                .with_content(%r{^\s*driftfile /var/lib/chrony/drift$})
                .with_content(%r{^\s*rtcsync$})
                .without_content(%r{^\s*dumpdir})
                .without_content(%r{^\s*\n\s*$})
            end
            it do
              is_expected.to contain_file(keys_file)
                .with_mode('0644')
                .with_owner('0')
                .with_group('0')
                .with_replace(true)
                .with_content("0 xyzzy\n")
            end
          end
        when 'RedHat'
          context 'using defaults' do
            it do
              is_expected.to contain_file(config_file)
                .with_content(%r{^\s*bindcmdaddress ::1$})
                .with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$})
                .without_content(%r{^\s*cmdallow.*$})
                .with_content(%r{^\s*server 0.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 1.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 2.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 3.pool.ntp.org iburst$})
                .with_content(%r{^\s*driftfile /var/lib/chrony/drift$})
                .with_content(%r{^\s*rtcsync$})
                .without_content(%r{^\s*dumpdir})
                .without_content(%r{^\s*\n\s*$})
            end
            it do
              is_expected.to contain_file(keys_file)
                .with_mode('0640')
                .with_owner('0')
                .with_group('chrony')
                .with_replace(true)
                .with_content("0 xyzzy\n")
            end
          end
        when 'Debian'
          context 'using defaults' do
            it do
              is_expected.to contain_file(config_file)
                .with_content(%r{^\s*bindcmdaddress ::1$})
                .with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$})
                .without_content(%r{^\s*cmdallow.*$})
                .with_content(%r{^\s*server 0.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 1.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 2.pool.ntp.org iburst$})
                .with_content(%r{^\s*server 3.pool.ntp.org iburst$})
                .with_content(%r{^\s*driftfile /var/lib/chrony/drift$})
                .with_content(%r{^\s*rtcsync$})
                .without_content(%r{^\s*dumpdir})
                .without_content(%r{^\s*\n\s*$})
            end
            it do
              is_expected.to contain_file(keys_file)
                .with_mode('0640')
                .with_owner('0')
                .with_group('0')
                .with_replace(true)
                .with_content("0 xyzzy\n")
            end
          end
        end
      end

      context 'with some params passed in' do
        let(:params) do
          {
            queryhosts: ['192.168/16'],
            port: 123,
            cmdport: 257,
            config_keys_mode: '0123',
            config_keys_owner: 'steve',
            config_keys_group: 'mrt',
            config_keys_manage: true,
            chrony_password: 'sunny',
            bindcmdaddress: ['10.0.0.1'],
            cmdacl: ['cmdallow 1.2.3.4', 'cmddeny 1.2.3', 'cmdallow all 1.2'],
            leapsecmode: 'slew',
            leapsectz: 'right/UTC',
            maxslewrate: 1000.0,
            smoothtime: '400 0.001 leaponly',
            rtconutc: true,
            hwtimestamps: ['eth0'],
            driftfile: '/var/tmp/chrony.drift',
            rtcsync: false,
            dumpdir: '/var/tmp',
          }
        end

        context 'chrony::config' do
          it do
            is_expected.to contain_file(config_file)
              .with_content(%r{^\s*leapsecmode slew$})
              .with_content(%r{^\s*leapsectz right/UTC$})
              .with_content(%r{^\s*leapsecmode slew$})
              .with_content(%r{^\s*maxslewrate 1000\.0$})
              .with_content(%r{^\s*smoothtime 400 0\.001 leaponly$})
              .with_content(%r{^\s*port 123$})
              .with_content(%r{^\s*cmdport 257$})
              .with_content(%r{^s*allow 192\.168\/16$})
              .with_content(%r{^\s*bindcmdaddress 10\.0\.0\.1$})
              .with_content(%r{^\s*cmdallow 1\.2\.3\.4$})
              .with_content(%r{^\s*cmddeny 1\.2\.3$})
              .with_content(%r{^\s*cmdallow all 1\.2$})
              .with_content(%r{^\s*rtconutc$})
              .with_content(%r{^\s*hwtimestamp eth0$})
              .with_content(%r{^\s*driftfile /var/tmp/chrony.drift$})
              .without_content(%r{^\s*rtcsync$})
              .with_content(%r{^\s*dumpdir /var/tmp$})
          end
          it do
            is_expected.to contain_file(keys_file)
              .with_mode('0123')
              .with_owner('steve')
              .with_group('mrt')
              .with_replace(true)
              .with_content("0 sunny\n")
          end
        end
      end

      describe 'stratumweight' do
        context 'by default' do
          it { is_expected.not_to contain_file(config_file).with_content(%r{stratumweight}) }
        end
        context 'when set' do
          let(:params) do
            {
              stratumweight: 0,
            }
          end

          it { is_expected.to contain_file(config_file).with_content(%r{^stratumweight 0$}) }
        end
      end

      context 'unmanaged chrony.keys file' do
        let(:params) do
          {
            config_keys_manage: false,
            chrony_password: 'unset',
          }
        end

        it { is_expected.to contain_file(keys_file).with_replace(false) }
        it { is_expected.to contain_file(keys_file).with_content('') }
      end

      context 'hwtimestamps as hash' do
        let(:params) do
          {
            hwtimestamps: { 'eth0' => ['minpoll 1', 'maxpoll 7'] },
          }
        end

        it { is_expected.to contain_file(config_file).with_content(%r{^\s*hwtimestamp eth0 minpoll 1 maxpoll 7$}) }
      end

      context 'unmanaged chrony.keys file and password' do
        let(:params) do
          {
            config_keys_manage: false,
          }
        end

        it { is_expected.to raise_error(%r{Setting \$config_keys_manage false and \$chrony_password at same time in chrony is not possible}) }
      end

      context 'on any other system' do
        let(:facts) do
          {
            osfamily: 'UnsupportedOS',
          }
        end

        it { is_expected.to raise_error(%r{The chrony module is not supported on an UnsupportedOS based system\.}) }
      end

      context 'chrony::service' do
        let :params do
          {
            service_ensure: 'running',
            service_enable: true,
            service_manage: true,
          }
        end

        case facts[:osfamily]
        when 'Archlinux'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chronyd').with(
                ensure: 'running',
                enable: true,
              )
            end
          end
        when 'RedHat', 'Gentoo'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chronyd').with(
                ensure: 'running',
                enable: true,
              )
            end
          end
        when 'Debian'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chrony').with(
                ensure: 'running',
                enable: true,
              )
            end
          end
        end
      end
    end
  end
end
