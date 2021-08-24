# 2-puppet_custom_http_response_header.pp
# Puppet manifest to install nginx
package { 'nginx':
  ensure => installed,
}

file_line { 'Add redirection, 301':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://fkadeal.com  permanent;',
}

file { '/var/www/html/index.html':
  content => 'Holberton School',
}

file { add_header X-Served-By ':
  content => '$HOSTNAME',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
