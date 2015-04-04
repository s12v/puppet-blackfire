class blackfire::agent inherits blackfire {

  $default_parameters = {
    manage => true,
    version => 'latest',
    manage_service => true,
    service_ensure => 'running',
    server_id => $server_id,
    server_token => $server_token,
    socket => 'unix:///var/run/blackfire/agent.sock',
    log_file => 'stderr',
    log_level => 1,
    collector => 'https://blackfire.io',
    http_proxy => '',
    https_proxy => '',
    ca_cert => '',
    spec => '',
  }
  $agent = merge($default_parameters, $agent)

  validate_bool($agent['manage'])
  validate_string($agent['version'])
  validate_bool($agent['manage_service'])
  validate_string($agent['running'])
  validate_string($agent['server_id'])
  validate_string($agent['server_token'])
  validate_string($agent['socket'])
  validate_string($agent['log_file'])
  if $agent['log_level'] < 1 or $agent['log_level'] > 4 {
    fail 'Ivalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error'
  }
  validate_string($agent['collector'])
  validate_string($agent['http_proxy'])
  validate_string($agent['https_proxy'])
  validate_string($agent['ca_cert'])
  validate_string($agent['spec'])

  if $agent['manage'] == true {
    anchor { '::blackfire::agent::begin': } ->
    class { '::blackfire::agent::install': } ->
    class { '::blackfire::agent::config': } ~>
    class { '::blackfire::agent::service': } ->
    anchor { '::blackfire::agent::end': }
  }

}
