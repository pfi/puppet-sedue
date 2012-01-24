# sedue::mongodb assumes sedue::supervise already called

define sedue::mongodb($user, $instance, $port, $pair, $dir, $run) {
  file { "sedue::${instance}::mongodb::directory_repos":
    path => $dir,
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory'
  }

  # generate script and then run it
  sedue::mongodb_script { "sedue::${instance}::mongodb::script":
    user => $user,
    instance => $instance,
    port => $port,
    pair => $pair,
    dir => $dir,
    run => $run,
    require => File["sedue::${instance}::mongodb::directory_repos"]
  }

  sedue::server_process { "sedue::${instance}::mongodb::process":
    instance => $instance,
    server_type => 'mongodb',
    run => $run,
    require => Sedue::Mongodb_script["sedue::${instance}::mongodb::script"]
  }
}
