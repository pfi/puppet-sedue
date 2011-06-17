define sedue::directory($user, $instance, $name) {
  file { "${sedue_home}/${name}/${instance}":
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory'
  }
}
