terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx"
}

resource "docker_container" "nginx_tf" {
  name  = "nginx_tf"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8082
  }

  read_only = true

  capabilities {
    drop = ["ALL"]
  }

user = "101:101"


tmpfs = {
  "/tmp"                 = ""
  "/var/run"             = "uid=101,gid=101"
  "/run"                 = "uid=101,gid=101"
  "/var/log/nginx"       = "uid=101,gid=101"
  "/var/cache/nginx"     = "uid=101,gid=101"
}

}
