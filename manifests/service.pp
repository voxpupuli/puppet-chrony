class chrony::service (
  $service_enable = $chrony::service_enable,
  $service_ensure = $chrony::service_ensure,
  $service_manage = $chrony::service_manage,
  $service_name   = $chrony::service_name,) inherits chrony {
  if !($service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'chrony':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
