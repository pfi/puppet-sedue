class sedue::assist_server_script($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server_script { 'assist_server_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'assist-server'
  }
}
