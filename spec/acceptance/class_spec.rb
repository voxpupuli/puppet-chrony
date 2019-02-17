require 'spec_helper_acceptance'

describe 'chrony class:' do
	context 'default parameters' do
		it 'runs successfully' do
			pp = "class { 'chrony': }"
			# Run it twice and test for idempotency
			apply_manifest(pp, catch_failures: true)
			expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
		end

		describe package('chrony') do
			it { is_expected.to be_installed }
		end
		
    service = case fact('os.family')
              when 'RedHat'
                'chronyd'
              else
                'chrony'
              end
		describe service(service) do
    	it { is_expected.to be_running }
    	it { is_expected.to be_enabled }
    end
  end
end
