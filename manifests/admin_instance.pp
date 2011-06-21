define sedue::admin_instance($user, $instance, $instance_file_content, $config_server) {
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

  file { "sedue::${instance}::admin::instance_file":
    path => "${sedue_home}/etc/${instance}.instance",
    owner => $user,
    group => $user,
    mode => '0644',
    content => $instance_file_content,
    require => File["${instance}_serve_directory"]
  }

  sedue::mongodb { "sedue::${instance}::admin::mongodb":
    user => $user,
    instance => $instance,
    port => $config_server['port'],
    pair => $config_server['pair'],
    run => $config_server['run'],
    require => File["sedue::${instance}::admin::instance_file"]
  }
}
