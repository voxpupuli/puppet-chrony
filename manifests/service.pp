# @summary Manages the chrony service
#
# @api private
class chrony::service {
  assert_private()

  if $chrony::service_manage {
    service { $chrony::service_name:
      ensure => $chrony::service_ensure,
      enable => $chrony::service_enable,
    }
  }
}
