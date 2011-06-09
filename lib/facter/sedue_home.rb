Facter.add(:sedue_home) {
  setcode { ENV['SEDUE_HOME'] }
}
