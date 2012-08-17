# Class: jboss
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
class jboss (
  $version      = $jboss::params::version,
  $target       = $jboss::params::target,
  $jmx_user     = $jboss::params::jmx_user,
  $jmx_password = $jboss::params::jmx_password
) inherits jboss::params {

  class { 'jboss::package':
    version => $version,
    target  => $target,
  } ->
  class { 'jboss::config':
    version      => $version,
    target       => $target,
    jmx_user     => $jmx_user,
    jmx_password => $jmx_password,
  } ~>
  class { 'jboss::service':
  }

}
