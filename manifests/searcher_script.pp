class sedue::searcher_script($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server_script { 'searcher_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'searcher'
  }
}