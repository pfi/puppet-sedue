# dependency on server_process is resolved by server.pp

define sedue::server_script($user, $instance, $config_servers, $server_type, $run) {
  # TODO: make these parameters assignable
  $server_sleep_interval = 3
  $server_name = '' # TODO: make this hostname or the value of name parameter

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

  # generate files for serve supervise
  file { "${instance}_${server_type}_run_file":
    path => "${sedue_home}/etc/serve/${instance}/${server_script_name}.run",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/server.run.erb"),
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_${server_type}_run_directory":
    path => "${sedue_home}/etc/serve/${instance}/${server_script_name}",
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory',
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_${server_type}_run_symlink":
    path => "${sedue_home}/etc/serve/${instance}/${server_script_name}/run",
    ensure => 'link',
    target => "${sedue_home}/etc/serve/${instance}/${server_script_name}.run",
    require => [File["${instance}_${server_type}_run_file"], File["${instance}_${server_type}_run_directory"]]
  }

  file { "${instance}_${server_type}_init_script":
    path => "${sedue_home}/etc/init.d/${server_script_name}-${instance}",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/server.init.d.erb")
  }
}
