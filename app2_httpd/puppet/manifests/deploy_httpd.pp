class httpd_docker {

exec { 'install_docker_if_needed':
  command => '/usr/bin/apt-get -q -y install docker.io',
  unless  => '/usr/bin/docker --version',
  path    => ['/usr/bin', '/bin'],
}


  service { 'docker':
    ensure  => running,
    enable  => true,
    require => Exec['install_docker_if_needed'],

  }


  exec { 'pull_httpd_image':
    command => '/usr/bin/docker pull httpd:alpine',
    unless  => '/usr/bin/docker images | grep httpd',
    require => Service['docker'],
  }

  exec { 'remove_old_httpd_container':
    command => '/usr/bin/docker rm -f httpd_puppet',
    onlyif  => '/usr/bin/docker ps -a --format "{{.Names}}" | grep -w httpd_puppet',
    require => Exec['pull_httpd_image'],
  }


  exec { 'run_httpd_container':
    command => "/usr/bin/docker run -d \
      --name httpd_puppet \
      -p 8083:80 \
      --read-only \
      --cap-drop=ALL \
      --tmpfs /tmp \
      --tmpfs /run \
      --tmpfs /var/log/httpd \
      --tmpfs /usr/local/apache2/logs \
      httpd:alpine",
    unless  => '/usr/bin/docker ps -a --format "{{.Names}}" | grep -w httpd_puppet',
    require => Exec['remove_old_httpd_container'],
  }

}



include httpd_docker
