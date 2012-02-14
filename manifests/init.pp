class jboss (
  $version,
){
  class { 'jboss::package':
    version => $version,
  }
}

