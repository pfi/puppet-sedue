class sedue::indexer_script($user, $instance, $config_servers) {
  sedue::server_script { 'indexer_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'indexer'
  } 
}