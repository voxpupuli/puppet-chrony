# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v0.4.0](https://github.com/voxpupuli/puppet-chrony/tree/v0.4.0) (2020-04-27)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.3.2...v0.4.0)

**Closed issues:**

- Missing a tag for v0.3.2 [\#66](https://github.com/voxpupuli/puppet-chrony/issues/66)

**Merged pull requests:**

- Fix several markdown lint issues [\#72](https://github.com/voxpupuli/puppet-chrony/pull/72) ([dhoppe](https://github.com/dhoppe))
- Update for Vox Pupuli migration [\#71](https://github.com/voxpupuli/puppet-chrony/pull/71) ([alexjfisher](https://github.com/alexjfisher))
- Support rtconutc option [\#68](https://github.com/voxpupuli/puppet-chrony/pull/68) ([Bluewind](https://github.com/Bluewind))
- Add `leapsectz` option config option [\#65](https://github.com/voxpupuli/puppet-chrony/pull/65) ([adrienthebo](https://github.com/adrienthebo))
- Enhance parameter validation with more data types [\#63](https://github.com/voxpupuli/puppet-chrony/pull/63) ([alexjfisher](https://github.com/alexjfisher))
- `pdk update` with `use_litmus` [\#62](https://github.com/voxpupuli/puppet-chrony/pull/62) ([alexjfisher](https://github.com/alexjfisher))
- Move static defaults out of params.pp [\#61](https://github.com/voxpupuli/puppet-chrony/pull/61) ([alexjfisher](https://github.com/alexjfisher))

## [v0.3.2](https://github.com/voxpupuli/puppet-chrony/tree/v0.3.2) (2020-01-14)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.3.1...v0.3.2)

**Implemented enhancements:**

- puppet-chrony should support configurable leap second handling [\#19](https://github.com/voxpupuli/puppet-chrony/issues/19)

**Closed issues:**

- Please allow using pool instead of just server [\#53](https://github.com/voxpupuli/puppet-chrony/issues/53)
- chrony service is not restarted if it crashes on ubuntu 16.04 [\#41](https://github.com/voxpupuli/puppet-chrony/issues/41)
- Add cmdport as option [\#28](https://github.com/voxpupuli/puppet-chrony/issues/28)
- chrony being restarted every time the module runs [\#18](https://github.com/voxpupuli/puppet-chrony/issues/18)

**Merged pull requests:**

- Remove 'Coverage Status' badge [\#60](https://github.com/voxpupuli/puppet-chrony/pull/60) ([alexjfisher](https://github.com/alexjfisher))
- Use full Apache 2.0 License text and add badge [\#59](https://github.com/voxpupuli/puppet-chrony/pull/59) ([alexjfisher](https://github.com/alexjfisher))
- Use puppet-strings for reference docs [\#58](https://github.com/voxpupuli/puppet-chrony/pull/58) ([alexjfisher](https://github.com/alexjfisher))
- Add stratumweight parameter [\#56](https://github.com/voxpupuli/puppet-chrony/pull/56) ([alexjfisher](https://github.com/alexjfisher))
- Treat keys file content as Sensitive [\#55](https://github.com/voxpupuli/puppet-chrony/pull/55) ([alexjfisher](https://github.com/alexjfisher))
- Support custom package source and provider [\#54](https://github.com/voxpupuli/puppet-chrony/pull/54) ([JannikJ](https://github.com/JannikJ))
- Doc update [\#52](https://github.com/voxpupuli/puppet-chrony/pull/52) ([przemas75](https://github.com/przemas75))
- skew second [\#51](https://github.com/voxpupuli/puppet-chrony/pull/51) ([przemas75](https://github.com/przemas75))

## [v0.3.1](https://github.com/voxpupuli/puppet-chrony/tree/v0.3.1) (2019-10-12)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.3.0...v0.3.1)

**Closed issues:**

- Update to work on RHEL 8 ? [\#44](https://github.com/voxpupuli/puppet-chrony/issues/44)
- update metadata to remove puppet-stdlib dependency [\#42](https://github.com/voxpupuli/puppet-chrony/issues/42)
- Document "port" setting [\#29](https://github.com/voxpupuli/puppet-chrony/issues/29)

**Merged pull requests:**

- cmdport [\#50](https://github.com/voxpupuli/puppet-chrony/pull/50) ([przemas75](https://github.com/przemas75))
- remove empty dirs and gitkeeps [\#49](https://github.com/voxpupuli/puppet-chrony/pull/49) ([iglov](https://github.com/iglov))
- Fail if queryhosts is set, but port is at default 0. [\#48](https://github.com/voxpupuli/puppet-chrony/pull/48) ([olifre](https://github.com/olifre))
- Add parameter $cmdacl [\#47](https://github.com/voxpupuli/puppet-chrony/pull/47) ([nbarrientos](https://github.com/nbarrientos))
- Confirmed RHEL 8 functionality [\#46](https://github.com/voxpupuli/puppet-chrony/pull/46) ([stevekay](https://github.com/stevekay))

## [v0.3.0](https://github.com/voxpupuli/puppet-chrony/tree/v0.3.0) (2019-08-05)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.6...v0.3.0)

**Merged pull requests:**

- Allow configuring bindcmdaddress [\#45](https://github.com/voxpupuli/puppet-chrony/pull/45) ([nbarrientos](https://github.com/nbarrientos))

## [v0.2.6](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.6) (2019-08-02)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.5...v0.2.6)

**Merged pull requests:**

- \(\#42\) remove dependency on puppetlabs-stdlib [\#43](https://github.com/voxpupuli/puppet-chrony/pull/43) ([vchepkov](https://github.com/vchepkov))
- Don't ignore port setting [\#40](https://github.com/voxpupuli/puppet-chrony/pull/40) ([bzed](https://github.com/bzed))

## [v0.2.5](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.5) (2019-02-18)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.4...v0.2.5)

**Closed issues:**

- Support 'pools' [\#37](https://github.com/voxpupuli/puppet-chrony/issues/37)

**Merged pull requests:**

- Add support for pools [\#38](https://github.com/voxpupuli/puppet-chrony/pull/38) ([giggsey](https://github.com/giggsey))

## [v0.2.4](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.4) (2019-01-07)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.3...v0.2.4)

**Closed issues:**

- Add tags for each version [\#34](https://github.com/voxpupuli/puppet-chrony/issues/34)
- No changelog available [\#33](https://github.com/voxpupuli/puppet-chrony/issues/33)

**Merged pull requests:**

- More complex support for refclock [\#36](https://github.com/voxpupuli/puppet-chrony/pull/36) ([jcpunk](https://github.com/jcpunk))

## [v0.2.3](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.3) (2018-10-05)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.2...v0.2.3)

## [v0.2.2](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.2) (2018-10-01)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.1...v0.2.2)

**Merged pull requests:**

- support for peers, variable local stratum, SUSE 12 [\#32](https://github.com/voxpupuli/puppet-chrony/pull/32) ([johnwarburton](https://github.com/johnwarburton))
- add log\_options for logging support [\#31](https://github.com/voxpupuli/puppet-chrony/pull/31) ([johnwarburton](https://github.com/johnwarburton))
- Add configuration of clientlog and clientloglimit. [\#30](https://github.com/voxpupuli/puppet-chrony/pull/30) ([olifre](https://github.com/olifre))
- Implement "makestep" config parameter. [\#27](https://github.com/voxpupuli/puppet-chrony/pull/27) ([olifre](https://github.com/olifre))
- \[Enhance\] add debian in readme tested os [\#26](https://github.com/voxpupuli/puppet-chrony/pull/26) ([othalla](https://github.com/othalla))

## [v0.2.1](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.1) (2018-05-26)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.1.2...v0.2.1)

**Closed issues:**

- Additional parameters needed: deny, enable\_lock\_all, mailonchange [\#20](https://github.com/voxpupuli/puppet-chrony/issues/20)

**Merged pull requests:**

- \[Enhance\] adding parameters [\#25](https://github.com/voxpupuli/puppet-chrony/pull/25) ([othalla](https://github.com/othalla))
- \[Fix\] titles in readme [\#24](https://github.com/voxpupuli/puppet-chrony/pull/24) ([othalla](https://github.com/othalla))

## [v0.1.2](https://github.com/voxpupuli/puppet-chrony/tree/v0.1.2) (2018-05-12)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.2.0...v0.1.2)

## [v0.2.0](https://github.com/voxpupuli/puppet-chrony/tree/v0.2.0) (2018-05-12)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.1.1...v0.2.0)

**Closed issues:**

- Allow refclock configuration parameter [\#16](https://github.com/voxpupuli/puppet-chrony/issues/16)
- How to further customize the servers list [\#13](https://github.com/voxpupuli/puppet-chrony/issues/13)
- chrony \>= 2.2 will thrown warnings [\#12](https://github.com/voxpupuli/puppet-chrony/issues/12)
- Incompatible with future parser [\#8](https://github.com/voxpupuli/puppet-chrony/issues/8)

**Merged pull requests:**

- Adding Debian support [\#23](https://github.com/voxpupuli/puppet-chrony/pull/23) ([othalla](https://github.com/othalla))
- Add OS support in Metadata & use contain instead of anchor [\#22](https://github.com/voxpupuli/puppet-chrony/pull/22) ([othalla](https://github.com/othalla))
- improve CI & test with puppet 4/5 [\#21](https://github.com/voxpupuli/puppet-chrony/pull/21) ([othalla](https://github.com/othalla))
- Add refclocks configuration parameter [\#17](https://github.com/voxpupuli/puppet-chrony/pull/17) ([islepnev](https://github.com/islepnev))
- Removed unsupported options [\#15](https://github.com/voxpupuli/puppet-chrony/pull/15) ([4N7](https://github.com/4N7))
- Remove unsupported options [\#14](https://github.com/voxpupuli/puppet-chrony/pull/14) ([4N7](https://github.com/4N7))
- make sure we iterate predictable over the hash [\#11](https://github.com/voxpupuli/puppet-chrony/pull/11) ([duritong](https://github.com/duritong))
- Make keys more configurable [\#10](https://github.com/voxpupuli/puppet-chrony/pull/10) ([roysjosh](https://github.com/roysjosh))

## [v0.1.1](https://github.com/voxpupuli/puppet-chrony/tree/v0.1.1) (2016-03-11)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Support autogeneration of key by chrony [\#9](https://github.com/voxpupuli/puppet-chrony/pull/9) ([traylenator](https://github.com/traylenator))
- fix travis [\#7](https://github.com/voxpupuli/puppet-chrony/pull/7) ([duritong](https://github.com/duritong))

## [v0.1.0](https://github.com/voxpupuli/puppet-chrony/tree/v0.1.0) (2015-03-08)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.9...v0.1.0)

**Merged pull requests:**

- fixes for future parser [\#6](https://github.com/voxpupuli/puppet-chrony/pull/6) ([duritong](https://github.com/duritong))

## [v0.0.9](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.9) (2014-10-19)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.8...v0.0.9)

**Merged pull requests:**

- secure default installation [\#5](https://github.com/voxpupuli/puppet-chrony/pull/5) ([duritong](https://github.com/duritong))
- Tests and fix queryaddresses [\#4](https://github.com/voxpupuli/puppet-chrony/pull/4) ([duritong](https://github.com/duritong))

## [v0.0.8](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.8) (2014-06-17)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.7...v0.0.8)

**Merged pull requests:**

- chrony.keys file should not be world readable [\#3](https://github.com/voxpupuli/puppet-chrony/pull/3) ([kmullin](https://github.com/kmullin))

## [v0.0.7](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.7) (2014-06-09)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.6...v0.0.7)

**Merged pull requests:**

- Add RHEL7 Support [\#2](https://github.com/voxpupuli/puppet-chrony/pull/2) ([bensallen](https://github.com/bensallen))

## [v0.0.6](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.6) (2014-04-27)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.5...v0.0.6)

**Merged pull requests:**

- RHEL support and support to specify hosts/networks allowed to query the daemon [\#1](https://github.com/voxpupuli/puppet-chrony/pull/1) ([ofalk](https://github.com/ofalk))

## [v0.0.5](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.5) (2013-07-21)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.4...v0.0.5)

## [v0.0.4](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.4) (2013-07-20)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.3...v0.0.4)

## [v0.0.3](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.3) (2013-07-20)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.2...v0.0.3)

## [v0.0.2](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.2) (2013-07-19)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/v0.0.1...v0.0.2)

## [v0.0.1](https://github.com/voxpupuli/puppet-chrony/tree/v0.0.1) (2013-07-19)

[Full Changelog](https://github.com/voxpupuli/puppet-chrony/compare/9135746419f23615af05bed60d9fb472d90fdbe5...v0.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
