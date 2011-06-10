# sedue_home is provided as a custom fact.

class sedue::instance($instance_name) {
  class { 'sedue::serve_supervise':
    user => 'nobu',
    instance => $instance_name
  }

  class { 'sedue::searcher_script':
    user => 'nobu',
    instance => $instance_name,
    config_servers => 'bull0:25999'
  }

  class { 'sedue::indexer_script':
    user => 'nobu',
    instance => $instance_name,
    config_servers => 'bull0:25999'
  }

  # TODO: create all necessary directories like $SEDUE_HOME/arc-dir/$INSTANCE
}
