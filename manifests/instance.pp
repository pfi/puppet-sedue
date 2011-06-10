# sedue_home is provided as a custom fact.

class sedue::instance($instance_name) {
  class { 'sedue::serve_supervise':
    user => 'nobu',
    instance => $instance_name
  }

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
