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
  $version       = $jboss::params::version,
  $instance_name = $jboss::params::instance_name,
  $target        = $jboss::params::target,
  $jmx_user      = $jboss::params::jmx_user,
  $jmx_password  = $jboss::params::jmx_password,
) inherits jboss::params {

  $conf_dir = "${target}/server/${instance_name}"

  file { '/etc/init.d/jboss':
    owner   => '0',
    group   => '0',
    mode    => '0755',
    content => template("jboss/${version}/jboss.${::osfamily}.erb"),
  }

  file { "${conf_dir}/conf/props/jmx-console-users.properties":
    owner   => 'jboss',
    group   => 'jboss',
    mode    => '0644',
    content => "${jmx_user}=${jmx_password}",
  }
}
