define sedue::proxy_script($user, $instance, $port, $options) {
  # extract options
  if ('workers' in $options) and ($options['workers'] > 0) {
    $workers = $options['workers']
  } else {
    $workers = $processorcount * 2 + 1
  }

  if 'timeout' in $options {
    $timeout_value = $options['timeout']
  } else {
    $timeout_value = 60
  }

  $bind_address = ":${port}"

  file { "sedue::${instance}::admin::proxy_conf_py":
    path => "${sedue_home}/etc/${instance}/sedue_proxy_conf.py",
    owner => $user,
    group => $user,
    mode => '0644',
    content => template("sedue/sedue_proxy_conf.py.erb")
  }

  file { "${instance}_sedue_proxy_run_file":
    path => "${sedue_home}/etc/serve/${instance}/sedue_proxy.run",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/sedue_proxy.run.erb"),
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_sedue_proxy_run_directory":
    path => "${sedue_home}/etc/serve/${instance}/sedue_proxy",
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory',
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_sedue_proxy_run_symlink":
    path => "${sedue_home}/etc/serve/${instance}/sedue_proxy/run",
    ensure => 'link',
    target => "${sedue_home}/etc/serve/${instance}/sedue_proxy.run",
    require => [File["${instance}_sedue_proxy_run_file"], File["${instance}_sedue_proxy_run_directory"]]
  }

  $server_type = 'sedue_proxy'
  $server_script_name = 'sedue_proxy'
  $server_sleep_interval = 3
  $server_name = '' # TODO
  file { "${instance}_sedue_proxy_init_script":
    path => "${sedue_home}/etc/init.d/sedue_proxy-${instance}",
    owner => $user,
    group => $user,
    mode => 0755,
    content => template("sedue/server.init.d.erb") # same one as Sedue servers
  }
}
