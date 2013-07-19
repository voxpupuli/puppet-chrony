class chrony::install (
  $package_ensure = $chrony::package_ensure,
  $package_name   = $chrony::package_name,) inherits chrony {
  package { 'chrony':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
