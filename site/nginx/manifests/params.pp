class nginx::params {

  case $facts['os']['family'] {
    'debian','redhat': {
      $package     = 'nginx'
      $owner       = 'root'
      $group       = 'root'
      $docroot     = '/var/www'
      $confdir     = '/etc/nginx'
      $blockdir    = '/etc/nginx/conf.d'
      $logdir      = '/var/log/nginx'
      $service     = 'nginx'
      $nginxconf   = 'nginx.conf'
      $defaultconf = 'default.conf'
    }
    default : {
      fail("osfamily ${facts['os']['family']} not supported")
    }
  }
  
  $user = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    default  => 'fail',
  }
  
  if $user == 'fail' {
    fail("osfamily ${facts['os']['family']} not supported")
  }
  
}