# sedue_home is provided as a custom fact.

define sedue::instance($user, $instance, $config_servers, $repository,
  $servers) {
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
    option => $servers['searcher']
  }

  sedue::server { "sedue::${instance}::query_server":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'query-server',
    option => $servers['query-server']
  }

  sedue::server { "sedue::${instance}::indexer":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'indexer',
    option => $servers['indexer']
  }

  if $repository['type'] == 'mongodb' {
    sedue::mongodb { "sedue::${instance}::mongodb_repository":
      user => $user,
      instance => $instance,
      port => $repository['port'],
      pair => $repository['pair'],
      dir => "${::sedue_home}/repos/${instance}",
      run => $repository['run']
    }
    sedue::server { "sedue::${instance}::document_repository":
      user => $user,
      instance => $instance,
      config_servers => $config_servers,
      server_type => 'document-repository',
      option => $servers['document-repository'],
      require => Sedue::Mongodb["sedue::${instance}::mongodb_repository"]
    }
  } else {
    sedue::directory { "sedue::${instance}::document_repository::directory_repos":
      user => $user,
      instance => $instance,
      category => "repos"
    }
    sedue::server { "sedue::${instance}::document_repository":
      user => $user,
      instance => $instance,
      config_servers => $config_servers,
      server_type => 'document-repository',
      option => $servers['document-repository'],
      require => Sedue::Directory["sedue::${instance}::document_repository::directory_repos"]
    }
  }

  sedue::server { "sedue::${instance}::archive_manager":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'archive-manager',
    option => $servers['archive-manager']
  }

  sedue::server { "sedue::${instance}::assist_server":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'assist-server',
    option => $servers['assist-server']
  }

  # TODO: create all necessary directories like $SEDUE_HOME/arc-dir/$INSTANCE
}
