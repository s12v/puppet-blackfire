class blackfire::php::config inherits blackfire::php {

  case $::osfamily {
    'debian': {
      $ini_path = '/etc/php5/mods-available/blackfire.ini'
    }
    'redhat': {
      $ini_path = '/etc/php.d/zz-blackfire.ini'
    }
    default: {
      fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
    }
  }

  $section = 'blackfire'

  ini_setting { 'blackfire.agent_socket':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.agent_socket',
    value   => $php['agent_socket']
  }

  ini_setting { 'blackfire.agent_timeout':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.agent_timeout',
    value   => $php['agent_timeout']
  }

  ini_setting { 'blackfire.server_id':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.server_id',
    value   => $php['server_id']
  }

  ini_setting { 'blackfire.server_token':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.server_token',
    value   => $php['server_token']
  }

  ini_setting { 'blackfire.log_level':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.log_level',
    value   => $php['log_level']
  }

  ini_setting { 'blackfire.log_file':
    ensure  => present,
    path    => $ini_path,
    section => $section,
    setting => 'blackfire.log_file',
    value   => $php['log_file']
  }

}
