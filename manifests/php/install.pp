# Installs the PHP extension
class blackfire::php::install inherits blackfire::php {
  ensure_packages('blackfire-php', {ensure => $::blackfire::php::params['version']})
}
