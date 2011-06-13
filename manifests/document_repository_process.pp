class sedue::document_repository_process($instance, $status) {
  sedue::server_process { 'document_repository_process':
    instance => $instance,
    status => $status,
    server_type => 'document-repository'
  }
}
