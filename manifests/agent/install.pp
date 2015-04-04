class blackfire::agent::install inherits blackfire::agent {
  package { 'blackfire-agent':
    ensure => $agent['version'],
  }
}
