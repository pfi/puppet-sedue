class sedue::indexer($user, $instance, $config_servers) {
  sedue::server { 'indexer':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'indexer'
  } 
}