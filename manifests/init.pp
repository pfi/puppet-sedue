class sedue {
  file { "${sedue_home}/var/lock/kick-sedue-puppet-agent.lock":
    ensure => absent
  }
}
