# frozen_string_literal: true

require 'spec_helper'

describe 'chrony::dnssrv' do
  let(:title) { '_ntp._udp.example.com' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      if %w[Archlinux Gentoo].include?(facts[:os]['family'])
        context 'with default parameters' do
          it { is_expected.to compile.and_raise_error(%r{does not package}) }
        end
      else
        context 'with default parameters' do
          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_service('chrony-dnssrv@_ntp._udp.example.com.timer').with(
              ensure: 'running',
              enable: true,
            )
          end
        end

        context 'with ensure => absent' do
          let(:params) do
            {
              ensure: 'absent',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_service('chrony-dnssrv@_ntp._udp.example.com.timer').with(
              ensure: 'stopped',
              enable: false,
            )
          end
        end

        context 'with an explicit srv_record' do
          let(:title) { 'custom-name' }
          let(:params) do
            {
              srv_record: '_ntp._udp.custom.com',
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_service('chrony-dnssrv@_ntp._udp.custom.com.timer') }
        end

        context 'with a record outside _ntp._udp' do
          let(:title) { '_ntp._tcp.example.com' }

          it { is_expected.not_to compile }
        end
      end
    end
  end
end
