define sedue::server_process($instance, $status, $server_type) {
  case $server_type {
    'searcher': {
      $server_bin_name = 'sedue-rpc-searcher'
      $server_script_name = 'sedue-searcher'
    }
    'query-server': {
      $server_bin_name = 'sedue-rpc-query-server'
      $server_script_name = 'sedue-query-server'
    }
    'indexer': {
      $server_bin_name = 'sedue-rpc-indexer'
      $server_script_name = 'sedue-indexer'
    }
    'document-repository': {
      $server_bin_name = 'sedue-doc-repository-server'
      $server_script_name = 'sedue-document-repository'
    }
    'archive-manager': {
      $server_bin_name = 'sedue-rpc-archive-manager'
      $server_script_name = 'sedue-archive-manager'
    }
    'assist-server': {
      $server_bin_name = 'sedue-assist-server'
      $server_script_name = 'sedue-assist-server'
    }
  }

  service { "${server_type}_process":
    path => "${sedue_home}/etc/init.d/",
    name => "${server_script_name}-${instance}",
    ensure => $status,
    hasstatus => 'true', # this need to be true
    provider => 'init',
    require => Class["sedue::serve_supervise"]
  }
}