define sedue::memcached_script($user, $instance, $port, $options) {
  $port_option = "-p ${port}"

  file { "${instance}_memcached_run_file":
    path => "${::sedue_home}/etc/serve/${instance}/memcached.run",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/memcached.run.erb"),
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_memcached_run_directory":
    path => "${::sedue_home}/etc/serve/${instance}/memcached",
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory',
    require => File["${instance}_serve_directory"]
  }

  file { "${instance}_memcached_run_symlink":
    path => "${::sedue_home}/etc/serve/${instance}/memcached/run",
    ensure => 'link',
    target => "${::sedue_home}/etc/serve/${instance}/memcached.run",
    require => [File["${instance}_memcached_run_file"], File["${instance}_memcached_run_directory"]]
  }

  $server_type = 'memcached'
  $server_script_name = 'memcached'
  $server_sleep_interval = 3
  $server_name = '' # TODO
  file { "${instance}_memcached_init_script":
    path => "${::sedue_home}/etc/init.d/memcached-${instance}",
    owner => $user,
    group => $user,
    mode => 0755,
    content => template("sedue/server.init.d.erb") # same one as Sedue servers
  }
}
