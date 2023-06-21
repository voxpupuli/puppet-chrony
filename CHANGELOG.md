# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.0.0](https://github.com/voxpupuli/puppet-chrony/tree/v3.0.0) (2023-06-21)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.6.0...v3.0.0)

**Breaking changes:**

- Drop EoL Debian 9 [\#173](https://github.com/voxpupuli/puppet-chrony/pull/173) ([traylenator](https://github.com/traylenator))
- Drop Puppet 6 support [\#170](https://github.com/voxpupuli/puppet-chrony/pull/170) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- puppetlabs/stdlib: Allow 9.x [\#175](https://github.com/voxpupuli/puppet-chrony/pull/175) ([bastelfreak](https://github.com/bastelfreak))
- Add puppet 8 support [\#174](https://github.com/voxpupuli/puppet-chrony/pull/174) ([bastelfreak](https://github.com/bastelfreak))
- add RHEL 9 to supported OS [\#168](https://github.com/voxpupuli/puppet-chrony/pull/168) ([tuxmea](https://github.com/tuxmea))

**Fixed bugs:**

- init: queryhosts and denyqueryhosts should accept empty strings [\#163](https://github.com/voxpupuli/puppet-chrony/pull/163) ([kenyon](https://github.com/kenyon))

**Merged pull requests:**

- chrony\_spec: remove redundant code [\#164](https://github.com/voxpupuli/puppet-chrony/pull/164) ([kenyon](https://github.com/kenyon))

## [v2.6.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.6.0) (2022-11-16)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.5.0...v2.6.0)

**Implemented enhancements:**

- allow logchange to be a float with an arbitrary range [\#161](https://github.com/voxpupuli/puppet-chrony/pull/161) ([jhoblitt](https://github.com/jhoblitt))

## [v2.5.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.5.0) (2022-08-11)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.4.1...v2.5.0)

**Implemented enhancements:**

- make config\_keys option optional [\#156](https://github.com/voxpupuli/puppet-chrony/pull/156) ([bastelfreak](https://github.com/bastelfreak))

## [v2.4.1](https://github.com/voxpupuli/puppet-chrony/tree/v2.4.1) (2022-08-02)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.4.0...v2.4.1)

**Implemented enhancements:**

- Add more config settings and prep EL9 support [\#151](https://github.com/voxpupuli/puppet-chrony/pull/151) ([jcpunk](https://github.com/jcpunk))
- Allow the password to be a Sensitive string. [\#150](https://github.com/voxpupuli/puppet-chrony/pull/150) ([jcpunk](https://github.com/jcpunk))

**Merged pull requests:**

- Identify the chrony files as being managed by puppet. [\#153](https://github.com/voxpupuli/puppet-chrony/pull/153) ([bschonec](https://github.com/bschonec))

## [v2.4.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.4.0) (2022-04-19)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.3.0...v2.4.0)

**Implemented enhancements:**

- Add `sched_priority` and `logbanner` options. [\#148](https://github.com/voxpupuli/puppet-chrony/pull/148) ([jcpunk](https://github.com/jcpunk))

**Merged pull requests:**

- Update github URLs to remove unauthenticated git [\#147](https://github.com/voxpupuli/puppet-chrony/pull/147) ([gcoxmoz](https://github.com/gcoxmoz))

## [v2.3.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.3.0) (2022-03-20)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.2.0...v2.3.0)

**Implemented enhancements:**

- Add support for several NTS settings. [\#145](https://github.com/voxpupuli/puppet-chrony/pull/145) ([Heidistein](https://github.com/Heidistein))
- Add confdir \(chrony.cond.d\) support [\#144](https://github.com/voxpupuli/puppet-chrony/pull/144) ([Heidistein](https://github.com/Heidistein))
- Add support for ntpsigndsocket [\#139](https://github.com/voxpupuli/puppet-chrony/pull/139) ([ipoddubny](https://github.com/ipoddubny))

**Closed issues:**

- ntpdsigndsocket option missing [\#107](https://github.com/voxpupuli/puppet-chrony/issues/107)
- Are we creating a invalid keyfile? [\#91](https://github.com/voxpupuli/puppet-chrony/issues/91)

## [v2.2.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.2.0) (2022-03-07)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.1.0...v2.2.0)

**Implemented enhancements:**

- remove params.pp, use hiera data instead [\#135](https://github.com/voxpupuli/puppet-chrony/pull/135) ([kenyon](https://github.com/kenyon))

**Fixed bugs:**

- Arch Linux: also manage chrony-wait.service  [\#141](https://github.com/voxpupuli/puppet-chrony/pull/141) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.1.0) (2021-11-23)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- Manage chrony-wait.service on RedHat and Suse [\#127](https://github.com/voxpupuli/puppet-chrony/pull/127) ([traylenator](https://github.com/traylenator))
- Add Ubuntu support [\#125](https://github.com/voxpupuli/puppet-chrony/pull/125) ([kenyon](https://github.com/kenyon))
- Add support for maxdistance [\#122](https://github.com/voxpupuli/puppet-chrony/pull/122) ([hoffie](https://github.com/hoffie))

**Fixed bugs:**

- Actually test services are running [\#128](https://github.com/voxpupuli/puppet-chrony/pull/128) ([traylenator](https://github.com/traylenator))

**Merged pull requests:**

- Allow stdlib 8.0.0 [\#126](https://github.com/voxpupuli/puppet-chrony/pull/126) ([smortex](https://github.com/smortex))
- Avoid duplicating variables [\#123](https://github.com/voxpupuli/puppet-chrony/pull/123) ([smortex](https://github.com/smortex))

## [v2.0.0](https://github.com/voxpupuli/puppet-chrony/tree/v2.0.0) (2021-07-08)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v1.0.0...v2.0.0)

**Breaking changes:**

- Drop EoL Puppet 5 support; Add Puppet 7 [\#117](https://github.com/voxpupuli/puppet-chrony/pull/117) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add initstepslew [\#116](https://github.com/voxpupuli/puppet-chrony/pull/116) ([jasonknudsen](https://github.com/jasonknudsen))
- Allow users to not set local stratum [\#113](https://github.com/voxpupuli/puppet-chrony/pull/113) ([unixsurfer](https://github.com/unixsurfer))
- Add support for maxupdateskew [\#112](https://github.com/voxpupuli/puppet-chrony/pull/112) ([unixsurfer](https://github.com/unixsurfer))
- add bindaddress option [\#110](https://github.com/voxpupuli/puppet-chrony/pull/110) ([jhunt-steds](https://github.com/jhunt-steds))

**Fixed bugs:**

- Fix CI on CentOS [\#114](https://github.com/voxpupuli/puppet-chrony/pull/114) ([smortex](https://github.com/smortex))

**Closed issues:**

- Make a new release [\#115](https://github.com/voxpupuli/puppet-chrony/issues/115)

**Merged pull requests:**

- Allow stdlib version 7.x [\#119](https://github.com/voxpupuli/puppet-chrony/pull/119) ([smortex](https://github.com/smortex))
- Add support for Debian 10 [\#118](https://github.com/voxpupuli/puppet-chrony/pull/118) ([smortex](https://github.com/smortex))
- Drop text pointing to previous repo/version [\#108](https://github.com/voxpupuli/puppet-chrony/pull/108) ([jcpunk](https://github.com/jcpunk))

## [v1.0.0](https://github.com/voxpupuli/puppet-chrony/tree/v1.0.0) (2021-01-05)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.4.0...v1.0.0)

**Breaking changes:**

- Drop EoL Debian 8 support [\#105](https://github.com/voxpupuli/puppet-chrony/pull/105) ([bastelfreak](https://github.com/bastelfreak))
- Drop Eol CentOS 6 support [\#104](https://github.com/voxpupuli/puppet-chrony/pull/104) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Restore behaviour of `servers` and `pools` parameters [\#103](https://github.com/voxpupuli/puppet-chrony/pull/103) ([alexjfisher](https://github.com/alexjfisher))
- queryhosts: enforce Array\[String\] data type [\#101](https://github.com/voxpupuli/puppet-chrony/pull/101) ([kenyon](https://github.com/kenyon))

**Merged pull requests:**

- Fix tests to work with rspec-puppet 2.8.0 [\#93](https://github.com/voxpupuli/puppet-chrony/pull/93) ([alexjfisher](https://github.com/alexjfisher))

## [v0.4.0](https://github.com/voxpupuli/puppet-chrony/tree/v0.4.0) (2020-10-25)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.3.2...v0.4.0)

This is the first release of this module under [Vox Pupuli](https://voxpupuli.org/)'s [puppet](https://forge.puppet.com/puppet) namespace.  It was migrated to Vox Pupuli from [oboe76/chrony](https://forge.puppet.com/oboe76/chrony).

**Implemented enhancements:**

- Add new `driftfile`, `hwtimestamps`, `rtcsync`, and `dumpdir` parameters [\#82](https://github.com/voxpupuli/puppet-chrony/pull/82) ([chrekh](https://github.com/chrekh))
- Add support for Gentoo [\#80](https://github.com/voxpupuli/puppet-chrony/pull/80) ([chrekh](https://github.com/chrekh))
- Support `rtconutc` option [\#68](https://github.com/voxpupuli/puppet-chrony/pull/68) ([Bluewind](https://github.com/Bluewind))
- Add `leapsectz` option config option [\#65](https://github.com/voxpupuli/puppet-chrony/pull/65) ([adrienthebo](https://github.com/adrienthebo))

**Fixed bugs:**

- Fix Arch Linux configuration [\#77](https://github.com/voxpupuli/puppet-chrony/pull/77) ([0x6d617474](https://github.com/0x6d617474))

**Closed issues:**

- avoid changing configuration when adding optional parameters [\#64](https://github.com/voxpupuli/puppet-chrony/issues/64)
- `peer` parameter doesn't do anything on ArchLinux [\#57](https://github.com/voxpupuli/puppet-chrony/issues/57)

**Merged pull requests:**

- Replace litmus with Beaker [\#98](https://github.com/voxpupuli/puppet-chrony/pull/98) ([alexjfisher](https://github.com/alexjfisher))
- Remove unnecessary test on $service\_ensure [\#88](https://github.com/voxpupuli/puppet-chrony/pull/88) ([chrekh](https://github.com/chrekh))
- Change occurrences of 'if !' to 'unless' where possible. [\#87](https://github.com/voxpupuli/puppet-chrony/pull/87) ([chrekh](https://github.com/chrekh))
- Add tests for gentoo [\#86](https://github.com/voxpupuli/puppet-chrony/pull/86) ([chrekh](https://github.com/chrekh))
- Fix wrong end-tag resulting in blank line. [\#85](https://github.com/voxpupuli/puppet-chrony/pull/85) ([chrekh](https://github.com/chrekh))
- Fix documentation about parameter port. [\#84](https://github.com/voxpupuli/puppet-chrony/pull/84) ([chrekh](https://github.com/chrekh))
- Convert template for chrony.keys from erb to epp [\#83](https://github.com/voxpupuli/puppet-chrony/pull/83) ([chrekh](https://github.com/chrekh))
- Remove default value of 0 for $port and allow $port to be unset [\#81](https://github.com/voxpupuli/puppet-chrony/pull/81) ([chrekh](https://github.com/chrekh))
- Consolidate templates and convert to epp\(\) [\#79](https://github.com/voxpupuli/puppet-chrony/pull/79) ([chrekh](https://github.com/chrekh))
- Enhance parameter validation with more data types [\#63](https://github.com/voxpupuli/puppet-chrony/pull/63) ([alexjfisher](https://github.com/alexjfisher))
- Move static defaults out of params.pp [\#61](https://github.com/voxpupuli/puppet-chrony/pull/61) ([alexjfisher](https://github.com/alexjfisher))

## [v0.3.2](https://forge.puppet.com/v3/files/aboe-chrony-0.3.2.tar.gz) (2020-01-14)

  **Merged pull requests:**

  - Remove 'Coverage status' badge [\#58|(https://github.com/aboe76/puppet-chrony/pull/58) ([alexjfisher](https://github.com/alexjfisher))
  - Use full Apache 2.0 License text and add badge [\#57|(https://github.com/aboe76/puppet-chrony/pull/57) ([alexjfisher](https://github.com/alexjfisher))
  - Use puppet-strings for reference docs [\#56|(https://github.com/aboe76/puppet-chrony/pull/56) ([alexjfisher](https://github.com/alexjfisher))
  - Add stratumweight parameter [\#55|(https://github.com/aboe76/puppet-chrony/pull/55) ([alexjfisher](https://github.com/alexjfisher))
  - Treat keys file content as Sensitive [\#54|(https://github.com/aboe76/puppet-chrony/pull/54) ([alexjfisher](https://github.com/alexjfisher))
  - Support custom package source and provider [\#53|(https://github.com/aboe76/puppet-chrony/pull/53) ([JannikJ](https://github.com/JannikJ))
  - Doc update [\#52|(https://github.com/aboe76/puppet-chrony/pull/52) ([przemas75](https://github.com/przemas75))
  - skew second [\#51|(https://github.com/aboe76/puppet-chrony/pull/51) ([przemas75](https://github.com/przemas75))

## [v0.3.1](https://forge.puppet.com/v3/files/aboe-chrony-0.3.1.tar.gz) (2019-10-12)

  **Merged pull requests:**

  - cmdport parameter [\#50|(https://github.com/aboe76/puppet-chrony/pull/50) ([przemas75](https://github.com/przemas75))

## [v0.3.0](https://forge.puppet.com/v3/files/aboe-chrony-0.3.0.tar.gz) (2019-08-05)

  **Merged pull requests:**

  - Confirmed RHEL 8 functionality [\#46|(https://github.com/aboe76/puppet-chrony/pull/46) ([stevekay](https://github.com/stevekay))
  - Add parameter $cmdacl (\#47|(https://github.com/aboe76/puppet-chrony/pull/47) ([nbarrientos](https://github.com/nbarrientos))

## [v0.2.6](https://forge.puppet.com/v3/files/aboe-chrony-0.2.6.tar.gz) (2019-08-02)

  **Merged pull requests:**

  - Allow configuring bindcmdaddress [\#45|(https://github.com/aboe76/puppet-chrony/pull/45) ([nbarrientos](https://github.com/nbarrientos))
  - remove dependency on puppetlabs-stdlib [\#42|(https://github.com/aboe76/puppet-chrony/pull/43) ([vchepkov](https://github.com/vchepkov))
  - Don't ignore port setting [\#40|(https://github.com/aboe76/puppet-chrony/pull/40) ([bzed](https://github.com/bzed))


## [v0.2.5](https://forge.puppet.com/v3/files/aboe-chrony-0.2.5.tar.gz) (2019-04-25)

  **Merged pull requests:**

  - Add support for pools [\#37|(https://github.com/aboe76/puppet-chrony/pull/37) ([giggsey](https://github.com/giggsey))

## [v0.2.4](https://forge.puppet.com/v3/files/aboe-chrony-0.2.4.tar.gz) (2019-01-07)

  **Merged pull requests:**

  - More complex support for refclock [\#36](https://github.com/aboe76/puppet-chrony/pull/36) ([jcpunk](https://github.com/jcpunk))


## [v0.2.3](https://forge.puppet.com/v3/files/aboe-chrony-0.2.3.tar.gz) (2018-10-05)

**Merged pull requests:**

- support for peers, variable local stratum, SUSE 12 [\#32](https://github.com/aboe76/puppet-chrony/pull/32) ([Warblefly](https://github.com/Warblefly))

## [v0.2.2](https://forge.puppet.com/v3/files/aboe-chrony-0.2.2.tar.gz) (2018-09-26)

**Merged pull requests:**

- add log_options for logging support [\#31](https://github.com/aboe76/puppet-chrony/pull/31) ([Warblefly](https://github.com/bastelfreak))
- Add configuration of clientlog and clientloglimit. [\#30](https://github.com/aboe76/puppet-chrony/pull/30) ([olifre](https://github.com/olifre))
- Implement "makestep" config parameter. [\#27](https://github.com/aboe76/puppet-chrony/pull/27) ([olifre](https://github.com/olifre))
- add debian in readme tested os [\#26](https://github.com/aboe76/puppet-chrony/pull/26) ([othalla](https://github.com/othalla))

## [v0.2.1](https://forge.puppet.com/v3/files/aboe-chrony-0.2.1.tar.gz) (2018-05-26)

**Merged pull requests:**

- adding parameters [\#25](https://github.com/aboe76/puppet-chrony/pull/25) ([othalla](https://github.com/othalla))
- fix titles in readme  [\#24](https://github.com/aboe76/puppet-chrony/pull/24) ([othalla](https://github.com/othalla))

## [v0.2.0](https://forge.puppet.com/v3/files/aboe-chrony-0.2.0.tar.gz) (2018-05-12)

**Merged pull requests:**

- Adding Debian support [\#23](https://github.com/aboe76/puppet-chrony/pull/23) ([othalla](https://github.com/othalla))
- Add OS support in Metadata & use contain instead of anchor [\#22](https://github.com/aboe76/puppet-chrony/pull/22) ([othalla](https://github.com/othalla))
- improve CI & test with puppet 4/5 [\#21](https://github.com/aboe76/puppet-chrony/pull/21) ([othalla](https://github.com/othalla))
- Add refclocks configuration parameter [\#17](https://github.com/aboe76/puppet-chrony/pull/17) ([islepnev](https://github.com/islepnev))

## [v0.1.2](https://forge.puppet.com/v3/files/aboe-chrony-0.1.2.tar.gz) (2017-10-31)

**Merged pull requests:**

- Removed unsupported options [\#15](https://github.com/aboe76/puppet-chrony/pull/15) ([4N7](https://github.com/4N7))
- Remove unsupported options [\#14](https://github.com/aboe76/puppet-chrony/pull/14) ([4N7](https://github.com/4N7))
- make sure we iterate predictable over the hash [\#11](https://github.com/aboe76/puppet-chrony/pull/11) ([duritong](https://github.com/duritong))
- Make keys more configurable [\#10](https://github.com/aboe76/puppet-chrony/pull/10) ([roysjosh](https://github.com/roysjosh))


## [v0.1.1](https://forge.puppet.com/v3/files/aboe-chrony-0.1.1.tar.gz)(2016-03-11)

- Allow chrony to create its own keys in chrony.keys
- configure owner,group and mode of chrony keys file
- test will run now
- skip older ruby version in test
- small fixes for travis

## [v0.1.0](https://forge.puppet.com/v3/files/aboe-chrony-0.1.0.tar.gz)(2015-03-08)

- fix future parser

## [v0.0.9](https://forge.puppet.com/v3/files/aboe-chrony-0.0.9.tar.gz)(2014-10-19)

- Secure default installation
- fix travis
- queryhost should be empty
- basic set of tests running

## [v0.0.8](https://forge.puppet.com/v3/files/aboe-chrony-0.0.8.tar.gz)(2014-07-17)

- Fix key params
- chrony.keys not world readable

## [v0.0.7](https://forge.puppet.com/v3/files/aboe-chrony-0.0.7.tar.gz)(2014-06-09)

- Fix path for config_key
- Set Red Hat chrony params
- Fix template Red Hat


## [v0.0.6](https://forge.puppet.com/v3/files/aboe-chrony-0.0.6.tar.gz)(2014-04-27)

- Add Red Hat support
- Add chrony params with queryhost
- Fix build

## [v0.0.5](https://forge.puppet.com/v3/files/aboe-chrony-0.0.5.tar.gz)(2013-03-21)

- Add license

## [v0.0.4](https://forge.puppet.com/v3/files/aboe-chrony-0.0.4.tar.gz)(2013-06-20)

- Fix travis button and testing


## [v0.0.3](https://forge.puppet.com/v3/files/aboe-chrony-0.0.3.tar.gz)(2013-06-20)

- Update Readme and spec test

## [v0.0.2](https://forge.puppet.com/v3/files/aboe-chrony-0.0.2.tar.gz)(2013-06-19)

- Update module forge with more information

## [v0.0.1](https://forge.puppet.com/v3/files/aboe-chrony-0.0.1.tar.gz)(2013-06-19)

- First release on forge



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
