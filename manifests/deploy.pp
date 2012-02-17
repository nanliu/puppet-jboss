define jboss::deploy (
  $source,
  $target        = '/usr/local/jboss',
  $instance_name = 'default'
){

  $conf_dir = "${target}/server/${instance_name}"
  case $name {
    /.ear$/: {
      $target = "${conf_dir}/deploy"
    }
    /.war$/: {
      $target = "${conf_dir}/lib"
    }
    default: {
      fail("jboss::deploy: unsupported file format ${name}")
    }
  }

  staging::file { $name:
    source => $source,
    target => $target,
    notify => Class['jboss::service'],
  }

}
