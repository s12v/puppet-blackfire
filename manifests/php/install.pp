class blackfire::php::install inherits blackfire::php {

  if !defined(Class['blackfire::repo']) {
    class { 'blackfire::repo': }
  }

  package { 'blackfire-php':
    ensure => $version,
  }

}
