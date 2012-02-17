define jboss::conf (
  $source        = undef,
  $content       = undef,
  $target        = '/usr/local/jboss',
  $instance_name = 'default'
){

  $conf_dir = "${target}/server/${instance_name}"

  file { "${conf_dir}/${name}":
    owner   => 'jboss',
    group   => 'jboss',
    mode    => '0644',
    source  => $source,
    content => $content,
    notify  => Class['jboss::service'],
  }

}
