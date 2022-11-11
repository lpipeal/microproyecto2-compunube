class komposeconfig {

  exec { 'descargar_kompose':
    command => 'curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.1/kompose-linux-amd64 -o kompose',
    cwd => '/home/vagrant/',
    path => '/usr/bin/';
    #require => Class['gitconfig'];
  }

  exec { 'otorgar_permisos_kompose':
    command => 'chmod +x kompose',
    cwd => '/home/vagrant/',
    path => '/usr/bin/',
    require => Exec['descargar_kompose'];
  }

  exec { 'mover_kompose':
    command => 'sudo mv ./kompose /usr/local/bin/kompose',
    cwd => '/home/vagrant/',
    path => '/usr/bin/',
    require => Exec['otorgar_permisos_kompose'];
  }