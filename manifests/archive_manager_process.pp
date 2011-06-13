class sedue::archive_manager_process($instance, $status) {
  sedue::server_process { 'archive_manager_process':
    instance => $instance,
    status => $status,
    server_type => 'archive-manager'
  }
}
