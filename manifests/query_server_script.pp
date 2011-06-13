class sedue::query_server_script($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server_script { 'query_server_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'query-server'
  }
}
