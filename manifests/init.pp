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
  $version      = hiera('jboss_version'),
  $target       = hiera('jboss_target'),
  $jmx_user     = hiera('jboss_jmx_user'),
  $jmx_password = hiera('jboss_jmx_password')
){

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
