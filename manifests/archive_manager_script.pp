class sedue::archive_manager_script($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server_script { 'archive_manager_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'archive-manager'
  }
}
