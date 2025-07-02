terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}


provider "docker" {}
resource "docker_image" "httpd" {
  name = "httpd:alpine"
}

resource "docker_container" "httpd_tf" {
  name  = "httpd_terraform"
  image = docker_image.httpd.name

  ports {
    internal = 80
    external = 8082
  }

  read_only = true

  capabilities {
    drop = ["ALL"]
  }

  tmpfs = {
    "/run"       = "uid=101,gid=101"
    "/tmp"       = ""
    "/var/log"   = "uid=101,gid=101"
    "/var/cache" = "uid=101,gid=101"
  "/usr/local/apache2/logs"      = "uid=101,gid=101"
  }

  user = "101:101"
}
