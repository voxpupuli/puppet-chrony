#!/usr/bin/ruby
require 'facter'

Facter.add('chrony_version') do
  confine :kernel => 'Linux'
  setcode do
    distid = Facter.value(:lsbdistid)
    case distid
    when /Debian|Ubuntu/
      Facter::Util::Resolution.exec("dpkg-query --showformat='${PACKAGE} ${VERSION}\n' --show | egrep 'chrony'")
    when /RedHatEnterprise|CentOS|Fedora/
      Facter::Util::Resolution.exec("rpm -qa --queryformat '[%{NAME} %{VERSION}-%{RELEASE}\n]' | egrep 'chrony'")
  end
end
