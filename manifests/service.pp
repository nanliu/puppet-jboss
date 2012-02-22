# Class: jboss::service
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
class jboss::service {

  service { 'jboss':
    ensure    => running,
    enable    => true,
    hasstatus => false,
    pattern   => 'org.jboss.Main',
  }

}
