class blackfire (
  $server_id = $blackfire::params::server_id,
  $server_token = $blackfire::params::server_token,
  $socket = $blackfire::params::socket,
  $log_level = $blackfire::params::log_level
) inherits blackfire::params {

  validate_string($server_id)
  validate_string($server_token)
  if !$server_id or !$server_token {
    fail('server_id and server_token are required. Get them on https://blackfire.io/account/agents')
  }

  validate_integer($log_level)
  if $log_level < 1 or $log_level > 4 {
    fail('Ivalid log_level. Valid levels are: 4 - debug, 3 - info, 2 - warning, 1 - error')
  }

  validate_string($socket)
}
