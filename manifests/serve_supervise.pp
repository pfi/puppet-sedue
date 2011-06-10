class sedue::serve_supervise($user, $instance) {
  file { 'serve_directory':
    path => "${sedue_home}/etc/serve/${instance_name}",
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '0755'
  }

  # generate symbolic link whose name contains the instance name
  # for grepability of process names.
  file { 'serve_supervise_bin_symlink':
    path => "${sedue_home}/bin/serve-supervise-${instance_name}",
    ensure => link,
    target => "${sedue_home}/bin/serve-supervise"
  }

  file { 'serve_supervise_init_script':
    path => "${sedue_home}/etc/init.d/serve-supervise-${instance}",
    owner => $user,
    group => $user,
    mode => '0755',
    content => template("sedue/serve-supervise.init.d.erb"),
    require => File['serve_directory']
  }

  service { 'serve_supervise_service':
    path => "${sedue_home}/etc/init.d/",
    name => "serve-supervise-${instance}",
    ensure => running,
    provider => 'init',
    require => [Class['searcher_script'], Class['indexer_script'], File['serve_supervise_init_script'], File['serve_supervise_bin_symlink']]
  }
}
