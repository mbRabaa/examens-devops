terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "salutation" {
  name         = "mbrabaa2023/spring-image:v1.0"
  keep_locally = false
}


resource "docker_container" "salutation" {
  image = docker_image.salutation.image_id
  name  = "salutation"

  ports {
    internal = 8888
    external = 9999
  }
}
