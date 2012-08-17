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
  $target        = undef,
  $instance_name = undef,
){

  include jboss::params
  if $instance_name {
    $r_instance_name = $instance_name
  } else {
    $r_instance_name = $jboss::params::instance_name
  }

  if $target {
    $r_target = $target
  } else {
    $r_target = $jboss::params::target
  }

  $conf_dir = "${r_target}/server/${r_instance_name}"

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
