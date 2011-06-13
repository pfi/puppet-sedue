class sedue::assist_server_process($instance, $status) {
  sedue::server_process { 'assist_server_process':
    instance => $instance,
    status => $status,
    server_type => 'assist-server'
  }
}
