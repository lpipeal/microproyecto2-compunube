class centosdockerconfig {

  exec { 'descargar_imagen':
    command => 'sudo docker pull jdeathe/centos-ssh-apache-php',
    path => '/usr/bin/',
    require => Class['dockerconfig'];
  }

  exec { 'corriendo_contenedor_centos':
    command => 'sudo docker run -d --name web1 -p 8800:80 jdeathe/centos-ssh-apache-php',
    path => '/usr/bin/',
    require => Exec['descargar_imagen'];
  }

}
