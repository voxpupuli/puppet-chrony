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

  service = case os[:family]
            when 'RedHat'
              'chronyd'
            else
              'chrony'
            end
  describe service(service) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
