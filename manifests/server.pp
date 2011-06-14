define sedue::server($user, $instance, $config_servers, $server_type, $run) {
  sedue::server_script { "sedue::${instance}::${server_type}::script":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => $server_type,
    run => $run
  }

  # TODO: add process
}