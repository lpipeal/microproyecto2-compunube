class kubernetesconfig {

  exec { 'descargar_minikube':
    command => 'curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64',
    path => '/usr/bin/';
    #require => Class['dockerconfig'];
  }

  exec { 'mover_minikube':
    command => 'sudo install -o root -g root -m 0755 minikube /usr/local/bin/minikube && rm minikube',
    path => '/usr/bin/',
    require => Exec['descargar_minikube'];
  }

  exec { 'actualizacion':
    command => 'sudo apt-get update && sudo apt-get install -y apt-transport-https',
    path => '/usr/bin/',
    require => Exec['mover_minikube'];
  }
  exec { 'descarga_kubectl':
    command => 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -',
    path => '/usr/bin/',
    require => Exec['actualizacion'];
  }
  exec { 'complemento_kubectl':
    command => 'echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list',
    path => '/usr/bin/',
    require => Exec['descarga_kubectl'];
  }
  exec { 'actualizacion2':
    command => 'sudo apt-get update && sudo apt-get install -y kubectl',
    path => '/usr/bin/',
    require => Exec['complemento_kubectl'];
  }

}
