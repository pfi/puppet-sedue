define sedue::admin_instance($user, $instance, $config_server) {
  sedue::directory { "sedue::${instance}::admin::directory_log":
    user => $user,
    instance => $instance,
    category => 'log'
  }

  sedue::serve_supervise { "sedue::${instance}::admin::serve_supervise":
    user => $user,
    instance => $instance,
    require => Sedue::Directory["sedue::${instance}::admin::directory_log"]
  }

  sedue::mongodb { "sedue::${instance}::admin::mongodb":
    user => $user,
    instance => $instance,
    port => $config_server['port'],
    pair => $config_server['pair'],
    run => $config_server['run'],
  }
}
