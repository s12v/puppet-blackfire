class blackfire::agent (
  $version = $blackfire::agent::params::version,
  $ca_cert = $blackfire::agent::params::ca_cert,
  $collector = $blackfire::agent::params::collector,
  $http_proxy = $blackfire::agent::params::http_proxy,
  $https_proxy = $blackfire::agent::params::https_proxy,
  $log_file = $blackfire::agent::params::log_file,
  $spec = $blackfire::agent::params::spec,

  $service_manage = $blackfire::agent::params::service_manage,
  $service_ensure = $blackfire::agent::params::service_ensure,

  # inherited
  $server_id = $blackfire::agent::params::server_id,
  $server_token = $blackfire::agent::params::server_token,
  $log_level = $blackfire::agent::params::log_level,
  $socket = $blackfire::agent::params::socket
) inherits blackfire::agent::params {

  validate_string($version)
  validate_string($ca_cert)
  if $ca_cert {
    validate_absolute_path($ca_cert)
  }
  validate_string($collector)
  validate_string($http_proxy)
  validate_string($https_proxy)
  validate_string($log_file)
  validate_string($spec)
  if $spec {
    validate_absolute_path($spec)
  }

  validate_bool($service_manage)
  validate_string($service_ensure)

  anchor { 'blackfire::agent::begin': } ->
      class { '::blackfire::agent::install': } ->
      class { '::blackfire::agent::config': } ~>
      class { '::blackfire::agent::service': } ->
  anchor { 'blackfire::agent::end': }

}
