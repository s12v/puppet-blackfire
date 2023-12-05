# Installs and configures Blackfire agent and PHP extension
#
# @param server_id
#
# @param server_token
#
# @param agent
#
# @param php
#
# @param manage_repo
#
class blackfire (
  Optional[String] $server_id    = $blackfire::params::server_id,
  Optional[String] $server_token = $blackfire::params::server_token,
  Hash $agent                    = $blackfire::params::agent,
  Hash $php                      = $blackfire::params::php,
  Boolean $manage_repo           = $blackfire::params::manage_repo
) inherits blackfire::params {
  if empty($server_id) or empty($server_token) {
    fail 'server_id and server_token are required. Get them on https://blackfire.io/account/agents'
  }

  contain 'blackfire::repo'
  contain 'blackfire::agent'
  contain 'blackfire::php'

  Class['blackfire::repo']
  -> Class['blackfire::agent']
  ~> Class['blackfire::php']
}
