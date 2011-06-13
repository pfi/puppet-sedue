class sedue::document_repository_script($user, $instance, $config_servers) {
  # TODO: support name parameter
  sedue::server_script { 'document_repository_script':
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => 'document-repository'
  }
}
