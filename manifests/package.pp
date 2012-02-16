class jboss::package (
  $uid          = hiera('jboss_uid', 201),
  $gid          = hiera('jboss_gid', 201),
  $shell        = hiera('jboss_shell', '/bin/sh'),
  $deployment   = hiera('jboss_deployment', 'file'),
  $package_name = hiera('jboss_package_name', 'jboss'),
  $version      = hiera('jboss_version', 7),
  # settings below only relevant for file deployment
  $source       = hiera('jboss_source', undef),
  $target       = hiera('jboss_target', '/usr/local/jboss')
) {

  include staging

  group { 'jboss':
    ensure => present,
    gid    => $uid,
  }

  user { 'jboss':
    ensure => present,
    home   => $target,
    uid    => $uid,
    gid    => $gid,
    shell  => $shell,
  }

  case $deployment {
    'file': {
      if $source {
        $jboss_source = $source
        } else {
          case $version {
            '5': { $jboss_source = 'http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip' }
            # Versions below untested:
            '6': { $jboss_source = 'http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip' }
            '7': { $jboss_source = 'http://download.jboss.org/jbossas/7.0/jboss-as-7.0.2.Final/jboss-as-web-7.0.2.Final.zip' }
          }
        }
        $filename = staging_parse($jboss_source, 'filename')
        $basename = staging_parse($jboss_source, 'basename')
        $extract_dir = staging_parse($target, 'parent')

        staging::deploy { $filename:
          source => $jboss_source,
          target => $extract_dir,
        }

        file { $target:
          ensure  => symlink,
          target  => "${extract_dir}/${basename}",
          require => Staging::Deploy[$filename],
        }

        file { '/etc/init.d/jboss':
          ensure  => file,
          owner   => '0',
          group   => '0',
          mode    => '0755',
          content => template("jboss/jboss.${version}.${::osfamily}.erb"),
        }
    }
    'package': {
      package { $package_name:
        ensure => $version,
      }
    }
  }

}
