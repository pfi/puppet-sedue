# sedue_home is provided as a custom fact.

class sedue::instance($instance_name) {
  file { 'serv_directory':
    path => "${sedue_home}/etc/serve/${instance_name}",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0755'
  }
  # TODO: generate serve-supervise_#{instance_name} symlink

  class { 'sedue::searcher':
    user => 'nobu',
    instance => $instance_name,
    config_servers => 'bull0:25999'
  }

  class { 'sedue::indexer':
    user => 'nobu',
    instance => $instance_name,
    config_servers => 'bull0:25999'
  }
}
