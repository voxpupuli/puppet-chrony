# @summary Type for DNS SRV records holding NTP servers.
#
# chrony-helper only accepts names below `_ntp._udp`. The domain may be omitted
# to let the resolver append its search list.
#
# @example A DNS SRV record
#   '_ntp._udp.example.com'
#
# @example A DNS SRV record resolved against the search domain
#   '_ntp._udp'
type Chrony::Srvrecord = Pattern[/\A_ntp\._udp(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*\.?\z/]
