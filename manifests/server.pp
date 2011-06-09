define sedue::server($user, $instance, $config_servers, $server_type) {
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
    require => File['serv_directory']
  }

  file { "${server_type}_init_script":
    path => "${sedue_home}/etc/init.d/${server_script_name}-${instance}",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/server.init.d.erb")
  }
}
