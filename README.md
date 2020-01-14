# puppet-chrony

[![License](https://img.shields.io/github/license/aboe76/puppet-chrony.svg)](https://github.com/aboe76/puppet-chrony/blob/master/LICENSE)
[![Build Status](https://secure.travis-ci.org/aboe76/puppet-chrony.png?branch=master)](http://travis-ci.org/aboe76/puppet-chrony)
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
#### Note
The parameter `port` is also set here,
module default is `0` to ensure server mode is not activated accidentally.

### How to configure leap second
```puppet
class { '::chrony':
  leapsecmode  => 'slew',
  smoothtime   => '400 0.001 leaponly',
  maxslewrate  => 1000.0
}
```

## Reference

Reference documentation for the chrony module is generated using
[puppet-strings](https://puppet.com/docs/puppet/latest/puppet_strings.html) and
available in [REFERENCE.md](REFERENCE.md)

## Limitations

This module has been built on and tested against Puppet 5.5 and higher.

The module has been tested on:
 * Arch Linux
 * Red Hat
 * Debian (9)
 * Suse 12.3
