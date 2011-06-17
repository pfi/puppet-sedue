# sedue::mongodb assumes sedue::supervise already called

define sedue::mongodb($user, $instance, $port, $pair, $run) { 
  if $run {
    $server_sleep_interval = 3
    $server_name = 'mongodb'
    $server_type = 'db'
    $server_script_name = $server_name

    if $pair {
      $mongodb_options = "--port ${port} --nohttpinterface --oplogSize 4096 --master --slave --source ${pair} --autoresync --quiet"
    } else {
      $mongodb_options = "--port ${port} --nohttpinterface --quiet"
    }

    file { "sedue::${instance}_mongodb_directory_repos":
      path => "${sedue_home}/repos/${instance}",
      owner => $user,
      group => $user,
      mode => '0755',
      ensure => 'directory'
    }

    # generate files for serve supervise
    file { "sedue::${instance}_mongodb_run_file":
      path => "${sedue_home}/etc/serve/${instance}/mongodb.run",
      owner => $user,
      group => $user,
      mode => '0755',
      content => template("sedue/mongodb.run.erb"),
      require => File["${instance}_serve_directory"]
    }

    file { "sedue::${instance}_mongodb_run_directory":
      path => "${sedue_home}/etc/serve/${instance}/mongodb",
      owner => $user,
      group => $user,
      mode => '0755',
      ensure => 'directory',
      require => File["${instance}_serve_directory"]
    }

    file { "sedue::${instance}_mongodb_run_symlink":
      path => "${sedue_home}/etc/serve/${instance}/mongodb/run",
      ensure => 'link',
      target => "${sedue_home}/etc/serve/${instance}/mongodb.run",
      require => [File["sedue::${instance}_mongodb_run_file"], File["sedue::${instance}_mongodb_run_directory"]]
    }

    file { "sedue::${instance}_mongodb_init_script":
      path => "${sedue_home}/etc/init.d/mongodb-${instance}",
      owner => $user,
      group => $user,
      mode => '0755',
      content => template("sedue/server.init.d.erb")
    }

    service { "sedue::${instance}_mongodb_process":
      path => "${sedue_home}/etc/init.d/",
      name => "mongodb-${instance}",
      ensure => 'running',
      hasstatus => 'true', # this need to be true
      provider => 'init',
      require => File["sedue::${instance}_mongodb_init_script"]
    }
  } else {
    service { "sedue::${instance}_mongodb_process":
      path => "${sedue_home}/etc/init.d/",
      name => "mongodb-${instance}",
      ensure => 'stopped',
      hasstatus => 'true', # this need to be true
      provider => 'init'
    }

    file { "sedue::${instance}_mongodb_init_script":
      path => "${sedue_home}/etc/init.d/mongodb-${instance}",
      ensure => 'absent',
      require => Service["sedue::${instance}_mongodb_process"]
    }

    # remove all unnecessary files
    file { "sedue::${instance}_mongodb_run_symlink":
      path => "${sedue_home}/etc/serve/${instance}/mongodb/run",
      ensure => 'absent',
      require => File["${instance}_serve_directory"]
    }

    file { "sedue::${instance}_mongodb_run_directory":
      path => "${sedue_home}/etc/serve/${instance}/mongodb",
      ensure => 'absent',
      force => true, # to remove dir/control, dir/stat
      require => File["sedue::${instance}_mongodb_run_symlink"]
    }

    file { "sedue::${instance}_mongodb_run_file":
      path => "${sedue_home}/etc/serve/${instance}/mongodb.run",
      ensure => 'absent',
      require => File["sedue::${instance}_mongodb_run_directory"]
    }
  }
}
