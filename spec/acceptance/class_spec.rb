require 'spec_helper_acceptance'

describe 'chrony class:' do
  it 'with defaults' do
    pp = <<-MANIFEST
      class { 'chrony': }
    MANIFEST

    idempotent_apply(pp)
  end

  describe package('chrony') do
    it { is_expected.to be_installed }
  end

  if os[:family] == 'RedHat'
    describe service(chronyd) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
  if os[:family] == 'Debian'
    describe service(chrony) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
