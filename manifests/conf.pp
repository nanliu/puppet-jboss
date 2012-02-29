# Define: jboss::conf
#
# Parameters:
#
#   * source: configuration file source. (use either source or content)
#   * content: configureation file content. (use either source or conent)
#   * target: jboss target deployment directory.
#   * instance_name: jboss instance name.
#
# Actions:
#
# Requires:
#
# Usage:
#
define jboss::conf (
  $source        = undef,
  $content       = undef,
  $instance_name = hiera('jboss_instance_name', 'default'),
  $target        = hiera('jboss_target', '/usr/local/jboss')
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
