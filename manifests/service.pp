# @summary Manages the chrony service
#
# @api private
class chrony::service (
  $service_enable = $chrony::service_enable,
  $service_ensure = $chrony::service_ensure,
  $service_manage = $chrony::service_manage,
  $service_name   = $chrony::service_name,
) inherits chrony {
  if $service_manage {
    service { $service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
}
