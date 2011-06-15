define sedue::serve_supervise($user, $instance) {
  file { 'serve_directory':
    path => "${sedue_home}/etc/serve/${instance}",
    ensure => 'directory',
    owner => $user,
    group => $user,
    mode => '0755'
  }

  # generate symbolic link whose name contains the instance name
  # for grepability of process names.
  file { 'serve_supervise_bin_symlink':
    path => "${sedue_home}/bin/serve-supervise-${instance}",
    ensure => link,
    target => "${sedue_home}/bin/serve-supervise"
  }
}
