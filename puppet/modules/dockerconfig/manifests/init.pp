class dockerconfig {

  exec { 'desinstalar_version_docker':
    command => 'sudo apt-get remove docker docker-engine docker.io containerd runc',
    path => '/usr/bin/';
  }

  exec { 'configurar_repositorio_https':
    command => 'sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -yy',
    path => '/usr/bin/',
    #require => Exec['desinstalar_version_docker'];
  }

  exec { 'configurar_gpg':
    command => 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo apt-key fingerprint 0EBFCD88',
    path => '/usr/bin/',
    require => Exec['configurar_repositorio_https'];
  }

  exec { 'agregar_repositorio_estable':
    command => 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
    path => '/usr/bin/',
    require => Exec['configurar_gpg'];
  }

  exec { 'instalar_verificar_docker':
    command => 'sudo apt-get install docker-ce docker-ce-cli containerd.io -y && sudo docker run hello-world',
    path => '/usr/bin/',
    require => Exec['agregar_repositorio_estable'];
  }

  exec { 'otorgar_permisos_docker':
    command => 'sudo chmod 666 /var/run/docker.sock',
    path => '/usr/bin/',
    require => Exec['instalar_verificar_docker'];
  }

}
