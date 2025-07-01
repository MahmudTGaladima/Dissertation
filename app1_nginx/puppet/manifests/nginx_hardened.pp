$nginx_port = lookup('nginx_port')

exec { 'remove-old-nginx-hardened':
  command => '/usr/bin/docker rm -f nginx-hardened',
  onlyif  => '/usr/bin/docker ps -a --format "{{.Names}}" | grep -w nginx-hardened',
  path    => ['/usr/bin', '/bin'],
}

exec { 'run-nginx-hardened':
  command => "/usr/bin/docker run -d \
    --name nginx-hardened \
    -p ${::nginx_port}:80 \
    --read-only \
    --tmpfs /tmp \
    --tmpfs /var/run:uid=101,gid=101 \
    --tmpfs /run:uid=101,gid=101 \
    --tmpfs /var/log/nginx:uid=101,gid=101 \
    --tmpfs /var/cache/nginx:uid=101,gid=101 \
    --cap-drop=ALL \
    --user 101:101 \
    --entrypoint /bin/sh \
    nginx \
    -c \"mkdir -p /var/cache/nginx/client_temp \
         && mkdir -p /var/log/nginx \
         && touch /var/log/nginx/error.log \
         && exec /docker-entrypoint.sh nginx -g 'daemon off;'\"",
  require => Exec['remove-old-nginx-hardened'],
  path    => ['/usr/bin', '/bin'],
}
