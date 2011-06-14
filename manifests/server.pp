define sedue::server($user, $instance, $config_servers, $server_type) {
  sedue::server_script { "sedue::${instance}::${server_type}::script":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => $server_type
  }

  # TODO: add process
}