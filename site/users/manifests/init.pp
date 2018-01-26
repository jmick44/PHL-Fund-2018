class users { 
  group { 'eagles':
    ensure => present,
    gid    => '10000'
  }

  user { 'foles':
    ensure => present,
    gid    => 'eagles',
  }
  
  user { 'wentz':
    ensure => absent,
  }
}