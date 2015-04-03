class blackfire (
  $server_id = $blackfire::params::agent_server_id
) inherits blackfire::params {

  validate_string($server_id)

  anchor { 'blackfire::begin': } ->
    class { '::blackfire::install': } ->
    class { '::blackfire::config': } ~>
    class { '::blackfire::service': } ->
  anchor { 'blackfire::end': }
}
