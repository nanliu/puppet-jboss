# class: jboss::config
#
#
class jboss::config (
  $version       = hiera('jboss_version', 5),
  $instance_name = hiera('jboss_instance_name', 'default'),
  $target        = hiera('jboss_target', '/usr/local/jboss'),
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
    replace => false,
  }

}
