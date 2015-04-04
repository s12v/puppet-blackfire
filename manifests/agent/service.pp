class blackfire::agent::service inherits blackfire::agent {

  if ! ($service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage {
    service { 'blackfire-agent':
      ensure => $service_ensure,
    }
  }

}
