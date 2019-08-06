require 'spec_helper'

describe 'chrony' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
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
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 0$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 127\.0\.0\.1$}) }
            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0644') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_group('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 xyzzy\n") }
          end
        when 'RedHat'
          context 'using defaults' do
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 0$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress ::1$}) }
            it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$}) }
            it { is_expected.not_to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow.*$}) }
            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0640') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_group('chrony') }
            it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 xyzzy\n") }
          end
        when 'Debian'
          context 'using defaults' do
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*port 0$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress ::1$}) }
            it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress 127\.0\.0\.1$}) }
            it { is_expected.not_to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow.*$}) }
            ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
            end
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_mode('0640') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_owner('0') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_group('0') }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(true) }
            it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content("0 xyzzy\n") }
          end
        end
      end

      context 'with some params passed in' do
        let(:params) do
          {
            queryhosts: ['192.168/16'],
            port: '123',
            config_keys_mode: '0123',
            config_keys_owner: 'steve',
            config_keys_group: 'mrt',
            config_keys_manage: true,
            chrony_password: 'sunny',
            bindcmdaddress: ['10.0.0.1'],
            cmdacl: ['cmdallow 1.2.3.4', 'cmddeny 1.2.3', 'cmdallow all 1.2'],
          }
        end

        context 'chrony::config' do
          case facts[:osfamily]
          when 'Archinux'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*allow 192\.168\/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 sunny\n") }
            end
          when 'RedHat'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*allow 192\.168\/16$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*bindcmdaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 sunny\n") }
            end
          when 'Debian'
            context 'with some params passed in' do
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*port 123$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^s*allow 192\.168\/16$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*bindcmdaddress 10\.0\.0\.1$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow 1\.2\.3\.4$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmddeny 1\.2\.3$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.conf').with_content(%r{^\s*cmdallow all 1\.2$}) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_mode('0123') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_owner('steve') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_group('mrt') }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(true) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content("0 sunny\n") }
            end
          end
        end
      end

      context 'unmanaged chrony.keys file' do
        let(:params) do
          {
            config_keys_manage: false,
            chrony_password: 'unset',
          }
        end

        context 'chrony::config' do
          case facts[:osfamily]
          when 'Archlinux'
            context 'unmanaged chrony.keys file' do
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(false) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content('') }
            end
          when 'RedHat'
            context 'unmanaged chrony.keys file' do
              it { is_expected.to contain_file('/etc/chrony.keys').with_replace(false) }
              it { is_expected.to contain_file('/etc/chrony.keys').with_content('') }
            end
          when 'Debian'
            context 'unmanaged chrony.keys file' do
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_replace(false) }
              it { is_expected.to contain_file('/etc/chrony/chrony.keys').with_content('') }
            end
          end
        end
      end

      context 'unmanaged chrony.keys file and password' do
        let(:params) do
          {
            config_keys_manage: false,
          }
        end

        it { is_expected.to raise_error(%r{Setting \$config_keys_manage false and \$chrony_password at same time in chrony is not possible}) }
      end

      context 'queryhosts set but port left at default 0' do
        let(:params) do
          {
            queryhosts: ['192.168/16'],
          }
        end

        it { is_expected.to raise_error(%r{Setting \$queryhosts has no effect unless also setting \$port which defaults to 0 in chrony, refusing that}) }
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
              is_expected.to contain_service('chrony').with(
                ensure: 'running',
                enable: true,
                hasstatus: true,
                hasrestart: true,
              )
            end
          end
        when 'RedHat'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chronyd').with(
                ensure: 'running',
                enable: true,
                hasstatus: true,
                hasrestart: true,
              )
            end
          end
        when 'Debian'
          context 'using defaults' do
            it do
              is_expected.to contain_service('chrony').with(
                ensure: 'running',
                enable: true,
                hasstatus: true,
                hasrestart: true,
              )
            end
          end
        end
      end
    end
  end
end
