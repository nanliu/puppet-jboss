# Class: jboss::data
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
class jboss::params {
  $version       = 5
  $deployment    = 'file'
  $target        = '/usr/local/jboss'
  $package_name  = 'jboss'
  $uid           = 201
  $gid           = 201
  $shell         = '/bin/sh'
  $instance_name = 'default'
  $jmx_user      = 'admin'
  $jmx_password  = 'changeme'
}
