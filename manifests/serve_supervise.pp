class sedue::serve_supervise($user, $instance) {
  file { 'serv_directory':
    path => "${sedue_home}/etc/serve/${instance_name}",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0755'
  }

  # generate symbolic link whose name contains the instance name
  # for grepability of process names.
  file { 'serve_bin_symlink':
    path => "${sedue_home}/bin/serve-supervise-${instance_name}",
    ensure => link,
    target => "${sedue_home}/bin/serve-supervise"
  }

  file { 'serve_init_script':
    path => "${sedue_home}/etc/init.d/serve-supervise-${instance}",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/serve-supervise.init.d.erb")
  }
}
