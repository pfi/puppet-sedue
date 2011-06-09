class sedue::instance {
  $sedue_home = '/home/nobu/sedue' # TODO: replace this with fact.
  file { 'serv_directory':
    path => "${sedue_home}/etc/serve/${instance}",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0755'
  }

  class { 'sedue::searcher':
    user => 'nobu',
    instance => 'puppet_test',
    config_servers => 'bull0:25999'
  }

  class { 'sedue::indexer':
    user => 'nobu',
    instance => 'puppet_test',
    config_servers => 'bull0:25999'
  }
}
