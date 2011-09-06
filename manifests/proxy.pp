define sedue::proxy($user, $instance, $port, $run, $options) {
  sedue::proxy_script { "sedue::${instance}::sedue_proxy::script":
    user => $user,
    instance => $instance,
    port => $port,
    options => $options
  }

  sedue::server_process { "sedue::${instance}::sedue_proxy::process":
    instance => $instance,
    server_type => 'proxy',
    run => $run,
    require => Sedue::Proxy_script["sedue::${instance}::sedue_proxy::script"]
  }
}
