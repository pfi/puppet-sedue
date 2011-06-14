# sedue_home is provided as a custom fact.

define sedue::instance($user, $instance, $config_servers) {
  sedue::serve_supervise { "sedue::${instance}::serve_supervise":
    user => $user,
    instance => $instance
  }

  sedue::server_script { "sedue::${instance}::searcher_script":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'searcher'
  }

  sedue::server_script { "sedue::${instance}::indexer_script":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'indexer'
  }

  # TODO: create all necessary directories like $SEDUE_HOME/arc-dir/$INSTANCE
}
