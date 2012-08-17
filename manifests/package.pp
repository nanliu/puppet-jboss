# Class: jboss::package
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
class jboss::package (
  $uid          = $jboss::params::uid,
  $gid          = $jboss::params::gid,
  $shell        = $jboss::params::shell,
  $deployment   = $jboss::params::deployment,
  $package_name = $jboss::params::package_name,
  $version      = $jboss::params::version,
  # settings below only relevant for file deployment
  $source       = $jboss_source,
  $target       = $jboss_target
) inherits jboss::params {

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
          # Versions below have not been tested:
          '6': { $jboss_source = 'http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip' }
          '7': { $jboss_source = 'http://download.jboss.org/jbossas/7.0/jboss-as-7.0.2.Final/jboss-as-web-7.0.2.Final.zip' }
          default: { fail("jboss::package: unknown version ${version} and no source provided") }
        }
      }

      $filename    = staging_parse($jboss_source, 'filename')
      $basename    = staging_parse($jboss_source, 'basename')
      $extract_dir = staging_parse($target, 'parent')

      staging::deploy { $filename:
        source => $jboss_source,
        target => $extract_dir,
      }

      # For now exec instead of file since we don't continuously manage this.
      exec { 'jboss_permission':
        command     => "chown -R jboss:jboss ${extract_dir}/${basename}",
        path        => '/usr/local/bin:/usr/bin:/bin',
        refreshonly => true,
        subscribe   => Staging::Deploy[$filename],
      }

      # Remove insecure jmx default user account.
      exec { 'remove_default_jmx_users':
        command     => "rm ${extract_dir}/${basename}/server/*/conf/props/jmx-console-users.properties",
        path        => '/usr/local/bin:/usr/bin:/bin',
        refreshonly => true,
        subscribe   => Staging::Deploy[$filename],
      }

      file { $target:
        ensure  => symlink,
        target  => "${extract_dir}/${basename}",
        require => Staging::Deploy[$filename],
      }
    }

    'package': {
      package { $package_name:
        ensure => $version,
      }
    }

    default: {
      fail("jboss::package: unsupported deployment method ${deployment}")
    }
  }

}
