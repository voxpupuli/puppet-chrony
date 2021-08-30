require 'spec_helper_acceptance'

describe 'chrony class:' do
  it 'works idempotently with no errors' do
    pp = <<-EOS
    class { 'chrony': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe package('chrony') do
    it { is_expected.to be_installed }
  end

  if fact('os.family') == 'RedHat'
    describe service('chronyd') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  else
    describe service('chrony') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
