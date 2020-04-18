# Samba + Avahi in Docker container

This repository contains sources for [fat0troll/samba-with-avahi](https://hub.docker.com/repository/docker/fat0troll/samba-with-avahi) - Docker container for as simple as possible
 sharing experience. After tiny tinkering you will get running Samba, ready to be advertized to
  local network via Avahi (and to host Time Machine backups for example).
  
**Note 1**: This container requires `host` or `macvlan` network type, and will **not** work in `bridge` (default mode) network. See `examples/docker-compose.yml` for details. If you can/want to make it work in `bridge` mode, PRs are welcome (see Note 3).

**Note 2**: This container is tested under Linux and built for linux/amd64 only. That's because this is the only architecture used in my servers at the time. If you want to, you can send PR with changes for building image for other architectures.

**Note 3**: The [repo](https://github.com/fat0troll/samba-with-avahi) on Github is a mirror, and main development is done at [source.hodakov.me](https://source.hodakov.me/containers/samba-with-avahi). You may send PR where you want: I will accept on both, but will merge it manually, if it's from Github.

## Preparations

There is no custom scripts or similar, this container consumes standart configuration files from Samba and Avahi. Example configuration file for Samba is included in `examples/samba` directory. Due to licensing issues Avahi example configuration files isn't included in this repository, so you need to grab it manually. You can do this by passing these commands:

```
$ docker create --name avahi-config fat0troll/samba-with-avahi
$ docker cp avahi-config:/etc/avahi .
$ docker rm avahi-config
```

In the generated config files for Avahi you may add/remove your services (under `services` folder), and you **should** disable DBus otherwise it will not start at all. Add this to `avahi-daemon.conf` first section:

```
enable-dbus=no
```

## Environment variables

There is one set of environment variables this container consumes: `USER*` (where `*` is replaced with a number, but technically it may be everything). The format of variables is `username,group,UID`: you can create inside a container user with your host UID and it will write files to your share locations seamlessly with host. Example of `env` file with some defined users is located in `examples` directory.

## Starting from command-line example

```
$ docker run -it --name samba --net=host \
	-v /path/to/avahi/configs:/etc/avahi \
	-v /path/to/samba/configs:/etc/samba \
	-v /path/to/samba/lib:/var/lib/samba \
	-v /path/to/shares:/data \
	fat0troll:avahi-with-docker
```

## Starting from docker stack example

See `examples/docker-compose.yaml`. This file may be deployed by command:

```
$ docker stack deploy -c examples/docker-compose.yaml samba
```