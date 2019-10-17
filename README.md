# puppet-chrony

[![Build Status](https://secure.travis-ci.org/aboe76/puppet-chrony.png?branch=master)](http://travis-ci.org/aboe76/puppet-chrony)
[![Coverage Status](https://coveralls.io/repos/github/aboe76/puppet-chrony/badge.svg?branch=master)](https://coveralls.io/github/aboe76/puppet-chrony?branch=master)
[![pdk version](https://img.shields.io/puppetforge/pdk-version/aboe/chrony.svg?style=flat)](https://forge.puppetlabs.com/aboe/chrony)
[![Puppet Forge](https://img.shields.io/puppetforge/v/aboe/chrony.svg?style=flat)](https://forge.puppetlabs.com/aboe/chrony)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/aboe/chrony.svg?style=flat)](https://forge.puppetlabs.com/aboe/chrony)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/aboe/chrony.svg?style=flat)](https://forge.puppetlabs.com/aboe/chrony)

## Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with chrony](#setup)
    * [What chrony affects](#what-chrony-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with chrony](#beginning-with-chrony)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

#### Chrony Puppet Module

Manage chrony time daemon on Archlinux and Redhat


## Module Description

The Chrony module handles running chrony in Archlinux and Redhat systems
with systemd.

## Setup

### What chrony affects

 * chrony package.
 * chrony configuration file.
 * chrony key file.
 * chrony service.

### Requirements

  * Puppet 4.6.1 or later.  Puppet 3 was supported up until release 0.2.0.

### Beginning with chrony

include '::chrony' is all you need to get it running. If you
wish to pass in parameters like which servers to use
then you can use:

```puppet
class { '::chrony':
  servers => ['ntp1.corp.com', 'ntp2.corp.com' ],
}
```

## Usage

All interaction with the chrony module can be done through
the main chrony class.

### I just want chrony, what's the minimum I need?

```puppet
include '::chrony'
```

### I just want to tweak the servers, nothing else.

```puppet
class { '::chrony':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com', ],
}
```

### I'd like to make sure a secret password is used for chronyc:
```puppet
class { '::chrony':
  servers         => [ 'ntp1.corp.com', 'ntp2.corp.com', ],
  chrony_password => 'secret_password',
}
```

### I'd like to use NTP authentication:
```puppet
class { '::chrony':
  keys            => [
    '25 SHA1 HEX:1dc764e0791b11fa67efc7ecbc4b0d73f68a070c',
  ],
  servers         => {
    'ntp1.corp.com' => ['key 25', 'iburst'],
    'ntp2.corp.com' => ['key 25', 'iburst'],
  },
}
```

### I'd like chronyd to auto generate a command key at startup:
```puppet
class { '::chrony':
   chrony_password    => 'unset',
   config_keys_manage => false,
}
```

### Allow some hosts
```puppet
class { '::chrony':
  queryhosts  => [ '192.168/16', ],
  port        => 123,
}
```

### How to configure leap second
```puppet
class { '::chrony':
  leapsecmode  => 'slew',
  smoothtime   => '400 0.001 leaponly',
  maxslewrate  => 1000.0
}
```

#### Note
The parameter `port` is also set here,
module default is `0` to ensure server mode is not activated accidentally.


## Reference

### Classes
 * chrony: Main class, includes all the rest.
 * chrony::install: Handles the packages.
 * chrony::config: Handles the configuration and key file.
 * chrony::service: Handles the service.

### Parameters

The following parameters are available in the chrony module

#### `bindcmdaddress`

Array of addresses of interfaces on which chronyd will listen for monitoring
command packets (defaults to localhost).

#### `chrony_password`

This sets the chrony password to be used in the key file.
By default a short fixed string is used. If set explicitly
to 'unset' then no password will setting will be added
to the keys file by puppet.

#### `cmdacl`

An array of ACLs for monitoring access. This expects a list of directives, for
example: `['cmdallow 1.2.3.4', 'cmddeny 1.2.3']`. The order will be respected at
the time of generating the configuration. The argument of the allow or deny
commands can be an address, a partial address or a subnet (see manpage for more
details).

#### `cmdport`

The cmdport directive allows the port that is used for run-time monitoring (via the chronyc program) to be altered from its default (323).

#### `commandkey`

This sets the key ID used by chronyc to authenticate to chronyd.

#### `config`

This sets the file to write chrony configuration into.

#### `config_template`

This determines which template puppet should use for the chrony configuration.

#### `config_keys`

This sets the file to write chrony keys into.

#### `config_keys_owner`

Specify unix owner of chrony keys file, defaults to 0.

#### `config_keys_group`

Specify unix group of chrony keys files, defaults to 0 on ArchLinux
and chrony on Redhat.

#### `config_keys_mode`

Specify unix mode of chrony keys files, defaults to 0644 on ArchLinux
and 0640 on Redhat.

#### `config_keys_template`

This determines which template puppet should use for the chrony key file.

#### `keys`

An array of key lines.  These are printed as-is into the chrony key file.

### `leapsecmode`

How to insert the leap second mode. Use one of possible values only: `leapsecmode ignore`. Or three other possible values (`system`, `step`, `slew`).

#### `local_stratum`

Override the stratum of the server which will be reported to clients
when the local reference is active. Defaults to 10

#### `log_options`

Specify which information is to be logged.

### `maxslewrate`

Maximum rate for chronyd to slew the time. Only float type values possible, for example: `maxslewrate 1000.0`.

#### `package_ensure`

This can be set to 'present' or 'latest' or a specific version to choose the
chrony package to be installed.

#### `package_name`

This determines the name of the package to install.

#### `peers`

This selects the servers to use for NTP peers (symmetric association).
It is an array of servers.

#### `servers`

This selects the servers to use for NTP servers.  It can be an array of servers
or a hash of servers to their respective options.

#### `refclocks`

This should be a Hash of hardware reference clock drivers to use.  They hash
can either list a single list of options for the driver, or any array of
multiple options if the same driver is used for multiple hardware clocks.

Example:
```
refclocks = { 'PPS' => [ '/dev/pps0 lock NMEA refid GPS',
                         '/dev/pps1:clear refid GPS2' ],
              'SHM' => '0 offset 0.5 delay 0.2 refid NMEA noselect' }
```

#### `makestep_updates`, `makestep_seconds`

This configures the `makestep` parameter of `chronyd`.
Usually, `chronyd` never steps the time, but applies a slew
after the initial synchronization.
This setting configures for how many _updates_ the time may be stepped
if the adjustment is larger than specified _seconds_.

For virtual machines which are suspended and resumed for a prolonged time,
stepping the time may be wanted. In this case, set `makestep_updates` to `-1`
to allow stepping the time for any update.

#### `queryhosts`

This adds the networks, hosts that are allowed to query the daemon.
Note that `port` needs to be set for this to work.

#### `port`

Port the service should listen on, to be used in combination with `queryhosts`.
Module default is `0` to prevent accidental activation of server mode.

#### `service_enable`

This determines if the service should be enabled at boot.

#### `service_ensure`

This determines if the service should be running or not.

#### `service_manage`

This selects if puppet should manage the service in the first place.

#### `service_name`

This selects the name of the chrony service for puppet to manage.

### `smoothtime`
Specify the smoothing of the time parameter as a string, for example `smoothtime 50000 0.01`.

#### `mailonchange`

Specify the mail you wanna alert when chronyd execute a sync grater than threshold.

#### `threshold`

Specify the time limit for triggering events.

#### `lock_all`

Force chrony to only use RAM & prevent swapping.

## Limitations

This module has been built on and tested against Puppet 3.2.3 and higher.

The module has been tested on:
 * Arch Linux
 * Red Hat
 * Debian (9)
 * Suse 12.3
