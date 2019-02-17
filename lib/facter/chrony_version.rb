Facter.add('chrony_version') do
    confine :kernel => 'Linux'
    setcode do
        if Facter::Core::Execution.which("chronyd")
            Facter::Core::Execution.execute("/bin/rpm -q --queryformat '%{VERSION}' chrony")
        else
            nil
        end
    end
end
