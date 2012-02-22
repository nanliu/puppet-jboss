jboss::deploy { 'dukesbank-2b.ear':
  source => 'puppet:///modules/dukesbank/dukesbank-2b.ear',
}

jboss::deploy { 'mysql.jdbc-5.1.6.jar':
  source => 'puppet:///modules/dukesbank/mysql.jdbc-5.1.6.jar',
}
