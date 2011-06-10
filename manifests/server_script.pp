define sedue::server_script($user, $instance, $config_servers, $server_type) {
  # TODO: make these parameters assignable
  $server_sleep_interval = 3
  $server_name = '' # TODO: make this hostname or the value of name parameter

  case $server_type {
    'searcher': {
      $server_bin_name = 'sedue-rpc-searcher'
      $server_script_name = 'sedue-searcher'
    }
    'indexer': {
      $server_bin_name = 'sedue-rpc-indexer'
      $server_script_name = 'sedue-indexer'
    }
  }

  file { "${server_type}_run_file":
    path => "${sedue_home}/etc/serve/${instance}/${server_script_name}.run",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/server.run.erb"),
    require => File['serve_directory']
  }

  file { "${server_type}_init_script":
    path => "${sedue_home}/etc/init.d/${server_script_name}-${instance}",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/server.init.d.erb")
  }
}
