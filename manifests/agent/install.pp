# Installs the agent
class blackfire::agent::install inherits blackfire::agent {
  ensure_packages('blackfire-agent', {ensure => $::blackfire::agent::params['version']})
}
