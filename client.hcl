data_dir = "/home/ubuntu/data/local-single-data"

bind_addr = "127.0.0.1"

plugin "containerd-driver" {
  config {
    enabled            = true
    containerd_runtime = "io.containerd.kata.v2"
    stats_interval     = "5s"
  }
}

client {
  enabled = true
  servers = ["127.0.0.1:4647"]
}

advertise {
  http = "127.0.0.1"
  rpc  = "127.0.0.1"
  serf = "127.0.0.1"
}

ports {
  http = 5641
  rpc  = 5642
  serf = 5643
}
