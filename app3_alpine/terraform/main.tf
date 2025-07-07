terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "alpine" {
  name = "alpine"
}


resource "docker_container" "alpine_curl" {
  name       = "alpine_tf"
  image      = docker_image.alpine.name
  must_run   = true
  command    = ["sh", "-c", "apk update && apk add curl && sleep 3600"]





  privileged    = false
  ipc_mode      = "none"
  security_opts = ["no-new-privileges"]
}
