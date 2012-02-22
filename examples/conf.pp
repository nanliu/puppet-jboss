jboss::conf { 'jboss-ds.xml':
  content => template('dukesbank/jboss-ds.xml.erb'),
}
