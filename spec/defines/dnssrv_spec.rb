# frozen_string_literal: true

require 'spec_helper'

describe 'chrony::dnssrv' do
  let(:title) { '_ntp._udp.example.com' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_file('/var/run/chrony-dnssrv/_ntp._udp.example.com.sh').with(
            ensure: 'file',
            owner: 'root',
            group: 'root',
            mode: '0755'
          )
        end

        it do
          is_expected.to contain_exec('dnssrv-initial-_ntp._udp.example.com').with(
            creates: '/var/run/chrony-dnssrv/_ntp._udp.example.com.sources'
          ).that_requires('File[/var/run/chrony-dnssrv/_ntp._udp.example.com.sh]')
        end

        it do
          is_expected.to contain_systemd__timer('chrony-dnssrv-_ntp__udp_example_com.timer').with(
            active: true,
            enable: true
          )
        end
      end

      context 'with ensure => absent' do
        let(:params) do
          {
            ensure: 'absent'
          }
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_file('/var/run/chrony-dnssrv/_ntp._udp.example.com.sources').with(
            ensure: 'absent'
          )
        end

        it do
          is_expected.to contain_file('/var/run/chrony-dnssrv/_ntp._udp.example.com.sh').with(
            ensure: 'absent'
          )
        end

        it do
          is_expected.to contain_systemd__timer('chrony-dnssrv-_ntp__udp_example_com.timer').with(
            active: false,
            enable: false
          )
        end
      end

      context 'with custom srv_record' do
        let(:title) { 'custom-name' }
        let(:params) do
          {
            srv_record: '_ntp._udp.custom.com'
          }
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_file('/var/run/chrony-dnssrv/_ntp._udp.custom.com.sh').with(
            ensure: 'file',
            owner: 'root',
            group: 'root',
            mode: '0755'
          )
        end

        it do
          is_expected.to contain_exec('dnssrv-initial-_ntp._udp.custom.com').with(
            creates: '/var/run/chrony-dnssrv/_ntp._udp.custom.com.sources'
          )
        end

        it do
          is_expected.to contain_systemd__timer('chrony-dnssrv-_ntp__udp_custom_com.timer').with(
            active: true,
            enable: true
          )
        end

        it do
          is_expected.to contain_file('/var/run/chrony-dnssrv/_ntp._udp.custom.com.sources').with(
            ensure: 'file'
          )
        end
      end

      context 'with custom sourcedir and poll_interval' do
        let(:params) do
          {
            sourcedir: '/custom/path',
            poll_interval: 8
          }
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_file('/custom/path/_ntp._udp.example.com.sh').with(
            ensure: 'file',
            mode: '0755'
          )
        end

        it do
          is_expected.to contain_exec('dnssrv-initial-_ntp._udp.example.com').with(
            creates: '/custom/path/_ntp._udp.example.com.sources'
          )
        end

        it do
          is_expected.to contain_file('/custom/path/_ntp._udp.example.com.sources').with(
            ensure: 'file'
          )
        end
      end
    end
  end
end
