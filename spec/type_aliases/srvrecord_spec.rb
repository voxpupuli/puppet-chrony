# frozen_string_literal: true

require 'spec_helper'

describe 'Chrony::Srvrecord' do
  [
    '_ntp._udp',
    '_ntp._udp.example.com',
    '_ntp._udp.example.com.',
    '_ntp._udp.sub.example.com',
  ].each do |value|
    describe value.inspect do
      it { is_expected.to allow_value(value) }
    end
  end

  [
    '_ntp._tcp.example.com',
    '_ntpx._udp.example.com',
    '_ntp._udpx.example.com',
    'ntp.example.com',
    '',
  ].each do |value|
    describe value.inspect do
      it { is_expected.not_to allow_value(value) }
    end
  end
end
