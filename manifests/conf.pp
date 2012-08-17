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
  $instance_name = undef,
  $target        = undef,
) {

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

  file { "${conf_dir}/${name}":
    owner   => 'jboss',
    group   => 'jboss',
    mode    => '0644',
    source  => $source,
    content => $content,
    notify  => Class['jboss::service'],
  }
}
