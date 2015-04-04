class blackfire::agent::install inherits blackfire::agent {

  if !defined(Class['blackfire::repo']) {
    class { 'blackfire::repo': }
  }

  package { 'blackfire-agent':
    ensure => $version,
  }

}
