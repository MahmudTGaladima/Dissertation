exec { 'run-nginx-container':
  command => '/usr/bin/docker run -d --name test-nginx -p 8080:80 nginx',
  unless  => '/usr/bin/docker ps | grep test-nginx',
  path    => ['/usr/bin', '/bin'],
}
