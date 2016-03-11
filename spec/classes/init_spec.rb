require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'chrony', :type => 'class' do
  describe 'using defaults' do
    context 'on redhat' do
      let(:facts){
        {
          :osfamily => 'RedHat'
        }
      }
      it { should compile.with_all_deps }
      it { should_not contain_file('/etc/chrony.conf').with_content(/^allow/) }
      it { should contain_file('/etc/chrony.conf').with_content(/^port 0$/) }
      ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org'].each do |s|
        it { should contain_file('/etc/chrony.conf').with_content(/^server #{s} iburst$/) }
      end
    end

    context 'on archlinux' do
      let(:facts){
        {
          :osfamily => 'Archlinux'
        }
      }
      it { should compile.with_all_deps }
      it { should_not contain_file('/etc/chrony.conf').with_content(/^allow/) }
      it { should contain_file('/etc/chrony.conf').with_content(/^port 0$/) }
      ['0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org'].each do |s|
        it { should contain_file('/etc/chrony.conf').with_content(/^server #{s} iburst$/) }
      end
    end
  end
  context 'on redhat with params' do
    let(:facts){
      {
        :osfamily => 'RedHat'
      }
    }
    let(:params){
      {
        :queryhosts => ['192.168/16' ],
        :port => '123'
      }
    }
    it { should contain_file('/etc/chrony.conf').with_content(/^port 123$/) }
    it { should contain_file('/etc/chrony.conf').with_content(/^allow 192\.168\/16$/) }
  end
  context 'on any other system' do
    it { expect {
      should compile
    }.to raise_error(/The chrony module is not supported on an  based system\./) }
  end
end

