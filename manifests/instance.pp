# sedue_home is provided as a custom fact.

define sedue::instance($instance) {
  sedue::serve_supervise { "sedue::${instance}::serve_supervise":
    user => 'nobu',
    instance => $instance
  }

  sedue::server_script { "sedue::${instance}::searcher_script":
    user => 'nobu',
    instance => $instance,
    config_servers => 'bull0:25999',
    server_type => 'searcher'
  }

  sedue::server_script { "sedue::${instance}::indexer_script":
    user => 'nobu',
    instance => $instance,
    config_servers => 'bull0:25999',
    server_type => 'indexer'
  }

  # TODO: create all necessary directories like $SEDUE_HOME/arc-dir/$INSTANCE
}
