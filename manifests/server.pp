define sedue::server($user, $instance, $config_servers, $server_type, $option) {
  # generate script and then run it
  sedue::server_script { "sedue::${instance}::${server_type}::script":
    user => $user,
    instance => $instance,
    config_servers => $config_servers,
    server_type => $server_type,
    option => $option
  }

  sedue::server_process { "sedue::${instance}::${server_type}::process":
    instance => $instance,
    server_type => $server_type,
    run => $option['run'],
    require => Sedue::Server_script["sedue::${instance}::${server_type}::script"]
  }
}
