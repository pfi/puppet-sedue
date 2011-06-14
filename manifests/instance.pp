# sedue_home is provided as a custom fact.

define sedue::instance($user, $instance, $config_servers,
  $run) {
  sedue::directories { "sedue::${instance}::directories":
    user => $user,
    instance => $instance
  }

  sedue::serve_supervise { "sedue::${instance}::serve_supervise":
    user => $user,
    instance => $instance,
    require => Sedue::Directories["sedue::${instance}::directories"]
  }

  sedue::server { "sedue::${instance}::searcher":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'searcher',
    run => $run['searcher']
  }

  sedue::server { "sedue::${instance}::query_server":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'query-server',
    run => $run['query-server']
  }

  sedue::server { "sedue::${instance}::indexer":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'indexer',
    run => $run['indexer']
  }

  sedue::server { "sedue::${instance}::document_repository":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'document-repository',
    run => $run['document-repository']
  }

  sedue::server { "sedue::${instance}::archive_manager":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'archive-manager',
    run => $run['archive-manager']
  }

  sedue::server { "sedue::${instance}::assist_server":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'assist-server',
    run => $run['assist-server']
  }

  # TODO: create all necessary directories like $SEDUE_HOME/arc-dir/$INSTANCE
}
