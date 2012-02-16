class jboss::package (
  $uid          = hiera('jboss_uid', 201),
  $gid          = hiera('jboss_gid', 201),
  $shell        = hiera('jboss_shell', '/bin/nologin'),
  $deployment   = hiera('jboss_deployment', 'file'),
  $package_name = hiera('jboss_package_name', 'jboss'),
  $version      = hiera('jboss_version', 7),
  # settings below only relevant for file deployment
  $filename     = hiera('jboss_filename', 'apache-jboss-6.0.35.tar.gz'),
  $source       = hiera('jboss_source', 'undef'),
  $target       = hiera('jboss_target', '/opt')
) {

  include staging

  group { 'jboss':
    ensure => present,
    gid    => $uid,
  }

  user { 'jboss':
    ensure => present,
    uid    => $uid,
    gid    => $gid,
    shell  => $shell,
  }

  case $deployment {
    'file': {
      if $source {
        $jboss_source = $source
        } else {
          case $jboss::package::version {
            '5': { $jboss_source = 'http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip/download' }
            '6': { $jboss_source = 'http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip' }
            '7': { $jboss_source = 'http://download.jboss.org/jbossas/7.0/jboss-as-7.0.2.Final/jboss-as-web-7.0.2.Final.zip' }
          }
        }
        $basename = staging_parse($filename, 'basename')

        staging::deploy { $basename:
          source => $jboss_source,
          target => $target,
        }

        file { "${target}/jboss":
          ensure => symlink,
          target => "${target}/${extract}",
        }
    }
    'package': {
      package { $package_name:
        ensure => $version,
      }
    }
  }

}
