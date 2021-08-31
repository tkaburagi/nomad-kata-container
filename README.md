
## Prep Ubuntu
```
git clone thisrepo
sudo apt update
sudo apt insatll -y golang
sudo apt install -y qemu-kvm libvirt-bin virtinst bridge-utils libosinfo-bin libguestfs-tools virt-top
ARCH=$(arch)
BRANCH="${BRANCH:-master}"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/katacontainers:/releases:/${ARCH}:/${BRANCH}/xUbuntu_$(lsb_release -rs)/ /' > /etc/apt/sources.list.d/kata-containers.list"
curl -sL  http://download.opensuse.org/repositories/home:/katacontainers:/releases:/${ARCH}:/${BRANCH}/xUbuntu_$(lsb_release -rs)/Release.key | sudo apt-key add -
sudo -E apt-get update
sudo -E apt-get -y install kata-runtime kata-proxy kata-shim
```

## Test
```
sudo ctr image pull docker.io/library/busybox:latest
sudo ctr run --runtime io.containerd.run.kata.v2 -t --rm docker.io/library/busybox:latest hello sh
```

## Prep Nomad
```
mkdir -p /home/ubuntu/data/local-single-data/plugins
cd /home/ubuntu/data/local-single-data/plugins
wget https://github.com/Roblox/nomad-driver-containerd/releases/download/v0.9.1/containerd-driver
chmod +x containerd-driver
```

## Run
```
cd thisrepodir
nohup sudo nomad agent -config=server.hcl > server.out &
nohup sudo nomad agent -config=client.hcl > client.out &
nomad job run kata.nomad
```

```console
$ nomad job status
ID          Type     Priority  Status   Submit Date
redis-kata  service  50        running  2021-08-31T07:13:20Z
```

```console
$ sudo kata-runtime list
ID                                                     PID         STATUS      BUNDLE                                                                                                     CREATED                          OWNER
redis-task-kata-9fe4945c-afde-9fbb-901b-acd6801d6159   -1          running     /run/containerd/io.containerd.runtime.v2.task/nomad/redis-task-kata-9fe4945c-afde-9fbb-901b-acd6801d6159   2021-08-31T07:13:23.135994168Z   #0
```

