class alpine_container {
  service { 'docker':
    ensure => running,
    enable => true,
  }

  exec { 'pull_alpine':
    command => '/usr/bin/docker pull alpine',
    unless  => '/usr/bin/docker images | grep alpine',
    require => Service['docker'],
  }

  exec { 'run_alpine_with_curl':
    command => '/usr/bin/docker run -d --name alpine_puppet --security-opt no-new-privileges --ipc=none alpine sh -c "apk update && apk add curl && sleep 3600"',
    unless  => '/usr/bin/docker ps -a | grep alpine_puppet',
    require => Exec['pull_alpine'],
  }


  file { '/etc/docker/daemon.json':
    content => '{
      "icc": false
    }',
    notify  => Service['docker'],
  }
}

include alpine_container
