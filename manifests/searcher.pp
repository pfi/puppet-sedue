class sedue::searcher($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server { 'searcher':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'searcher'
  }
}