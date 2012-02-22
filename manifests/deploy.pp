# Define: jboss::deploy
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
define jboss::deploy (
  $source,
  $target        = hiera('jboss_target', '/usr/local/jboss'),
  $instance_name = hiera('jboss_instance_name', 'default')
){

  $conf_dir = "${target}/server/${instance_name}"

  case $name {
    /.ear$/: {
      $target_dir = "${conf_dir}/deploy"
    }
    /.jar$/: {
      $target_dir = "${conf_dir}/lib"
    }
    default: {
      fail("jboss::deploy: unsupported file format ${name}")
    }
  }

  staging::file { $name:
    source => $source,
    target => "${target_dir}/${name}",
    notify => Class['jboss::service'],
  }

}
