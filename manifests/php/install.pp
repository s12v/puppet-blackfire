class blackfire::php::install inherits blackfire::php {
  package { 'blackfire-php':
    ensure => $php['version'],
  }
}
