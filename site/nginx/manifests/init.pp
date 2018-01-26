class nginx (
  $package     = $nginx::params::package,
  $owner       = $nginx::params::owner,
  $group       = $nginx::params::group,
  $docroot     = $nginx::params::docroot,
  $confdir     = $nginx::params::confdir,
  $blockdir    = $nginx::params::blockdir,
  $logdir      = $nginx::params::logdir,
  $service     = $nginx::params::service,
  $nginxconf   = $nginx::params::nginxconf,
  $defaultconf = $nginx::params::defaultconf,
  $user        = $nginx::params::user,
  $message     = "This came from nginx class parameter defaults",
) inherits nginx::params {

  File {
     owner => $owner,
     group => $group,
     mode  => '0755',
  }
  
  notify { "MESSAGE IS ------- ${message}": }

  file { $docroot:
     ensure => directory,
  }
  
  file { 'index':
     ensure  => file,
     path    => "${docroot}/index.html",
     mode    => '0644',
     #source  => 'puppet:///modules/nginx/index.html',
     content => template('nginx/index.html.erb'),
     require => File[$docroot],
     before  => Service[$service],
  }
  
  package { $package:
     ensure => present,
  }
  
  file { $blockdir:
     ensure => directory,
     before => File["${blockdir}/${defaultconf}"],
  }
  
  file { "${confdir}/${nginxconf}":
     ensure  => file,
     mode    => '0644',
     #source  => 'puppet:///modules/nginx/nginx.conf',
     content => template('nginx/nginx.conf.erb'),
     require => Package[$package],
     notify  => Service[$service],
  }
  
  file { "${blockdir}/${defaultconf}":
     ensure  => file,
     mode    => '0644',
     #source  => 'puppet:///modules/nginx/default.conf',
     content => template('nginx/default.conf.erb'),
     require => Package[$package],
     notify  => Service[$service],
  }
  
  service { $service:
     ensure => running,
  }
}