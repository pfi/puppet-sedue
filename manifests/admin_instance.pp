define sedue::admin_instance($user, $instance, $admin_conf, $config_server) {
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

  # 2011/6/23 Masahiro Nakagawa <nakagawa@preferred.jp>
  # Virtual resource does not work for unique resource across each instances.
  # I use 'if !defined' to avoid this problem.
  if !defined(File["sedue::admin::conf_directory"]) {
    file { "sedue::admin::conf_directory":
      path => "${::sedue_home}/etc/${instance}",
      owner => $user,
      group => $user,
      mode => '0755',
      ensure => 'directory'
    }
  }

  file { "sedue::${instance}::admin::conf_file":
    path => "${::sedue_home}/etc/${instance}/admin.conf",
    owner => $user,
    group => $user,
    mode => '0644',
    content => $admin_conf,
    require => [File["sedue::admin::conf_directory"], File["${instance}_serve_directory"]]
  }

  sedue::mongodb { "sedue::${instance}::admin::mongodb":
    user => $user,
    instance => $instance,
    port => $config_server['port'],
    pair => $config_server['pair'],
    dir => $config_server['dir'],
    run => $config_server['run'],
    require => File["sedue::${instance}::admin::conf_file"]
  }
}
