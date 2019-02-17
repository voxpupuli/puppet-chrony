require 'spec_helper'

describe 'chrony' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('chrony') }
        it { is_expected.to contain_class('chrony::install') }
        it { is_expected.to contain_class('chrony::config') }
        it { is_expected.to contain_class('chrony::service') }
        it { is_expected.to contain_package('chrony').with_ensure('present') }
        it { is_expected.to contain_service('chrony').with_ensure('running') }
        it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 0$}) }
        ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org'].each do |s|
          it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*server #{s} iburst$}) }
        end
        it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0644') }
        it { is_expected.to contain_file('/etc/chrony.keys').with_owner('0') }
        it { is_expected.to contain_file('/etc/chrony.keys').with_group('chrony') }
        it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
        it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 xyzzy\n") }
      end
      context 'with some params passed in' do
        let(:params) do
          {
            :queryhosts => ['192.168/16'],
            :port => '123',
            :config_keys_mode   => '0123',
            :config_keys_owner  => 'steve',
            :config_keys_group  => 'mrt',
            :config_keys_manage => true,
            :chrony_password    => 'sunny',
          }
        end
        it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^\s*port 123$}) }
				it { is_expected.to contain_file('/etc/chrony.conf').with_content(%r{^s*allow 192\.168\/16$}) }
				it { is_expected.to contain_file('/etc/chrony.keys').with_mode('0123') }
				it { is_expected.to contain_file('/etc/chrony.keys').with_owner('steve') }
				it { is_expected.to contain_file('/etc/chrony.keys').with_group('mrt') }
				it { is_expected.to contain_file('/etc/chrony.keys').with_replace(true) }
				it { is_expected.to contain_file('/etc/chrony.keys').with_content("0 sunny\n") }
		  end	
      context 'unmanaged chrony.keys file' do
        let(:params) do
          {
            :config_keys_manage => false,
            :chrony_password    => 'unset',
          }
        end
			  it { is_expected.to contain_file('/etc/chrony.keys').with_replace(false) }
				it { is_expected.to contain_file('/etc/chrony.keys').with_content("") }
		  end
			context 'unmanaged chrony.keys file and password' do
        let(:params) do
          {
            :config_keys_manage => false,
          }
        end
        it { is_expected.to raise_error(/Setting \$config_keys_manage false and \$chrony_password at same time in chrony is not possible\./) }
		  end
		  context 'on any other system' do
			  let(:facts){
          {
            :osfamily => 'UnsupportedOS',
          }
        }
        it { is_expected.to raise_error(/The chrony module is not supported on an UnsupportedOS based system\./) }
		  end
    end
  end
end
