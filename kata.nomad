job "redis-kata" {
  datacenters = ["dc1"]

  group "redis-group-kata" {
    task "redis-task-kata" {
      driver = "containerd-driver"

      config {
        image = "docker.io/library/redis:alpine"
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
