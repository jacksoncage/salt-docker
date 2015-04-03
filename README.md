Easy Saltstack testing with Docker
===========

This repo provides a Saltstack setup with one master and one (or multiple) minions to be able to test and work with states, pillars and all other salt functionality. By using docker it's easy to reproduce and test you code.

Image includes both salt-master, salt-minion, salt-api and also salt-cloud to be able to test and troubleshoot all things salt. `SALT_USE` environment variable is used to determent if container should be running as master or minion.

Salt master is auto accepting all minions.

# Get it running

## Salt master/minon with docker run

```
$ sudo docker run -i -t -n saltdocker_master_1 -h master -p 4505 -p 4506 -p 8080 -p 8081 -e SALT_NAME=master -v `pwd`/srv:/srv:rw jacksoncage/salt
```

By jumping in with `docker exec -i -t saltdocker_master_1 bash` your able to start salt minion as well, and to test/troubleshoot

```
$ service salt-minion start
```

Now your ready to write you states and test them out.

## Salt cluster with docker compose
*This steps are done for OSX only*

Using docker [machine](https://github.com/docker/machine) and [composer](https://github.com/docker/compose) to get a multi-minion setup. Copy and configure `docker-compose.yml.example` to `docker-compose.yml` and run the following

```
$ brew install docker-machine docker-compose
$ docker-machine create --driver virtualbox salt
$ eval "$(docker-machine env salt)"
$ docker-compose up
```

# Environment variables
Env variables are used to set config on startup, you can set the following envs

 - `SALT_USE`  - master/minion, defaults to master
 - `SALT_NAME` - minion name, defaults to to master
 - `LOG_LEVEL` - log level, defaults to info
 - `OPTIONS`   - other options passed into salt process, defaults to none

# Volumes

Following paths can be mounted from the container. `/srv/salt` is needed to run your local states.

 - `/etc/salt` - Master/Minion config
 - `/var/cache/salt` - job data cache
 - `/var/logs/salt` - logs
 - `/srv/salt` - states, pillar reactors

# Build

## Use the pre built image
The pre built image can be downloaded using docker directly. After that you do not need to use this command again, you will have the image on your local computer.

```
$ sudo docker pull jacksoncage/salt
```

## Build the docker image by yourself
If you prefer you can easily build the docker image by yourself. After this the image is ready for use on your machine and can be used for multiple starts.

```
$ git clone git@github.com:jacksoncage/salt-docker.git
$ cd salt-docker
$ sudo docker build -t jacksoncage/salt .
```
