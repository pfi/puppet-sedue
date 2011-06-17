define sedue::directory($user, $instance, $category) {
  file { "${sedue_home}/${category}/${instance}":
    owner => $user,
    group => $user,
    mode => '0755',
    ensure => 'directory'
  }
}
