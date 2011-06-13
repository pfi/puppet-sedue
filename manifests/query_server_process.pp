class sedue::query_server_process($instance, $status) {
  sedue::server_process { 'query_server_process':
    instance => $instance,
    status => $status,
    server_type => 'query-server'
  }
}
