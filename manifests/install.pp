# @summary Installs chrony
#
# @api private
class chrony::install (
  $package_ensure   = $chrony::package_ensure,
  $package_name     = $chrony::package_name,
  $package_source   = $chrony::package_source,
  $package_provider = $chrony::package_provider,
) inherits chrony {
  package { 'chrony':
    ensure   => $package_ensure,
    name     => $package_name,
    source   => $package_source,
    provider => $package_provider,
  }

}
