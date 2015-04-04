class blackfire::php (
  $version = $blackfire::php::params::version,
  $log_file = $blackfire::php::params::log_file,
  $agent_timeout = $blackfire::php::params::agent_timeout,

  # inherited
  $server_id = $blackfire::php::params::server_id,
  $server_token = $blackfire::php::params::server_token,
  $log_level = $blackfire::php::params::log_level,
  $socket = $blackfire::php::params::socket
) inherits blackfire::php::params {

  validate_string($version)
  validate_string($log_file)
  validate_numeric($agent_timeout)

  anchor { 'blackfire::php::begin': } ->
      class { '::blackfire::php::install': } ->
      class { '::blackfire::php::config': } ->
  anchor { 'blackfire::php::end': }
}
