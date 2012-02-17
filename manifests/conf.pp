define jboss::conf (
  $source  = undef,
  $content = undef,
  $target        = '/usr/local/jboss',
  $instance_name = 'default'
){

  $conf_dir = "${target}/server/${instance_name}"

  file { $name:
    source => $source,
    target => $target,
    notice => Class['jboss::service'],
  }
}
