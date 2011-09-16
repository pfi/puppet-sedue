define sedue::server_process($instance, $server_type, $run) {
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
    'mongodb': {
      $server_bin_name = 'mongodb'
      $server_script_name = 'mongodb'
    }
    'proxy': {
      $server_bin_name = 'sedue_proxy'
      $server_script_name = 'sedue_proxy'
    }
    'memcached': {
      $server_bin_name = 'memcached'
      $server_script_name = 'memcached'
    }
  }

  if $run {
    $status = 'running'
  } else {
    $status = 'stopped'
  }

  service { "${instance}_${server_type}_process":
    path => "${sedue_home}/etc/init.d/",
    name => "${server_script_name}-${instance}",
    ensure => $status,
    hasstatus => 'true', # this need to be true
    provider => 'init'
    # A dependency on a corresponding init-script is solved by server.pp
  }
}
