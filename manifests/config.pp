# Class: jboss::config
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
class jboss::config (
  $version       = hiera('jboss_version', 5),
  $instance_name = hiera('jboss_instance_name'),
  $target        = hiera('jboss_target'),
  $jmx_user      = hiera('jboss_jmx_user', 'admin'),
  $jmx_password  = hiera('jboss_jmx_password', 'changeme')
) {

  file { '/etc/init.d/jboss':
    owner   => '0',
    group   => '0',
    mode    => '0755',
    content => template("jboss/${version}/jboss.${::osfamily}.erb"),
  }

  $conf_dir = "${target}/server/${instance_name}"

  File {
    owner => 'jboss',
    group => 'jboss',
    mode  => '0644',
  }

  file { "${conf_dir}/conf/props/jmx-console-users.properties":
    content => "${jmx_user}=${jmx_password}",
  }

}
