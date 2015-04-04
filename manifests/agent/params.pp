class blackfire::agent::params inherits blackfire {
  $version = 'present'

  $ca_cert = ''
  $collector = 'https://blackfire.io'
  $http_proxy = ''
  $https_proxy = ''
  $log_file = 'stderr'
  $spec = ''

  $service_manage = true
  $service_ensure = 'running'
}
