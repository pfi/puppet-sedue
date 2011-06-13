class sedue::searcher_process($instance, $status) {
  sedue::server_process { 'searcher_process':
    instance => $instance,
    status => $status,
    server_type => 'searcher'
  }
}
