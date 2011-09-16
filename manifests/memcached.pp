define sedue::memcached($user, $instance, $port, $run, $options) {
  sedue::memcached_script { "sedue::${instance}::memcached::script":
    user => $user,
    instance => $instance,
    port => $port,
    options => $options
  }

  sedue::server_process { "sedue::${instance}::memcached::process":
    instance => $instance,
    server_type => 'memcached',
    run => $run,
    require => Sedue::Memcached_script["sedue::${instance}::memcached::script"]
  }
}
