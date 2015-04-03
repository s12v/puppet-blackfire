
class blackfire::service inherits blackfire {

#  if ! (blackfire::service_ensure in [ 'running', 'stopped' ]) {
#    fail('service_ensure parameter must be running or stopped')
#  }
#
#  if blackfire::service_manage == true {
#    service { 'blackfire':
#      ensure     => blackfire::service_ensure,
#      enable     => blackfire::service_enable,
#      name       => blackfire::service_name,
#      hasstatus  => true,
#      hasrestart => true,
#    }
#  }

}