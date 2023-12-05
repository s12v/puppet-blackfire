# Installs and configures Blackfire agent
class blackfire::agent inherits blackfire {
  $default_params = {
    manage => true,
    version => 'latest',
    manage_service => true,
    service_ensure => 'running',
    server_id => $blackfire::server_id,
    server_token => $blackfire::server_token,
    socket => 'unix:///var/run/blackfire/agent.sock',
    log_file => 'stderr',
    log_level => 1,
    collector => 'https://blackfire.io',
    http_proxy => '',
    https_proxy => '',
    ca_cert => '',
    spec => '',
  }
  $params = merge($default_params, $blackfire::agent)

  $log_level = 0 + $params['log_level']

  if $log_level < 1 or $log_level > 4 {
    fail 'Invalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error'
  }

  if $params['manage'] == true {
    contain 'blackfire::agent::install'
    contain 'blackfire::agent::config'
    contain 'blackfire::agent::service'

    Class['blackfire::agent::install']
    -> Class['blackfire::agent::config']
    ~> Class['blackfire::agent::service']
  }
}
