class motd {

  package { 'cowsay':
    ensure   => present,
    provider => gem,
  } ->
  
  exec { 'motd':
    command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motd",
    path    => '/usr/local/bin',
    creates => '/etc/motd',
  }
}