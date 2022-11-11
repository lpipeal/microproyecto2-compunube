class dockercomposeconfig {

  exec { 'instalar_docker_compose':
    command => 'sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose',
    path => '/usr/bin/';
  }

  exec { 'otorgar_permisos_docker_compose':
    command => 'sudo chmod +x /usr/local/bin/docker-compose',
    path => '/usr/bin/',
    require => Exec['instalar_docker_compose'];
  }

}
