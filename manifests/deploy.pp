define jboss::deploy (
  $source,
  $jboss_target        = '/usr/local/jboss',
  $jboss_instance_name = 'default'
){

  $conf_dir = "${target}/server/${instance_name}"
  case $name {
    /.ear$/: {
      $target = "${conf_dir}/deploy"
    }
    /.war$/: {
      $target = "${conf_dir}/lib"
    }
  }

  staging::file { $name:
    source => $source,
    target => $target,
    notice => Class['jboss::service'],
  }
}
