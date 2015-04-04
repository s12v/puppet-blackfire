class blackfire::php inherits blackfire {

  $default_parameters = {
    manage => true,
    version => 'latest',
    server_id => $server_id,
    server_token => $server_token,
    agent_socket => 'unix:///var/run/blackfire/agent.sock',
    log_file => '',
    log_level => 1,
    agent_timeout => 0.25,
  }
  $php = merge($default_parameters, $php)

  validate_bool($php['manage'])
  validate_string($php['version'])
  validate_string($php['server_id'])
  validate_string($php['server_token'])
  validate_string($php['socket'])
  validate_string($php['log_file'])
  if $php['log_level'] < 1 or $php['log_level'] > 4 {
    fail 'Ivalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error'
  }

  anchor { '::blackfire::php::begin': } ->
    class { '::blackfire::php::install': } ->
    class { '::blackfire::php::config': } ->
  anchor { '::blackfire::php::end': }

}
