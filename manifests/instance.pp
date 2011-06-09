# sedue_home is provided as a custom fact.

class sedue::instance {
  file { 'serv_directory':
    path => "${sedue_home}/etc/serve/puppet_test",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0755'
  }
  # TODO: generate serve-supervise_#{instance} symlink

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
