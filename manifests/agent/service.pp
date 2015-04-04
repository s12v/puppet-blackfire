class blackfire::agent::service inherits blackfire::agent {

  if ! ($agent['service_ensure'] in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $agent['manage_service'] {
    service { 'blackfire-agent':
      ensure => $agent['service_ensure'],
    }
  }

}
