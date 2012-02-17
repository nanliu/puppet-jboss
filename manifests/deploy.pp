define jboss::deploy (
  $source,
  $target        = '/usr/local/jboss',
  $instance_name = 'default'
){

  $conf_dir = "${target}/server/${instance_name}"
  case $name {
    /.ear$/: {
      $target_dir = "${conf_dir}/deploy"
    }
    /.war$/: {
      $target_dir = "${conf_dir}/lib"
    }
    default: {
      fail("jboss::deploy: unsupported file format ${name}")
    }
  }

  staging::file { $name:
    source => $source,
    target => $target_dir,
    notify => Class['jboss::service'],
  }

}
