# The Onion's Docker Services

This is a set of containers that provide basic services for use in development. The idea here is that we have an "onion", "clickhole", "avclub" container each, and those link to these.

## OSX Setup instructions

1. Install Docker:

  `brew install docker docker-machine docker-compose`

2. Create Docker machine VirtualBox VM (recommended 4GB RAM, 40GB HD). For example, to create machine named 'dev':

  `docker-machine create --driver virtualbox --virtualbox-boot2docker-url https://github.com/boot2docker/boot2docker/releases/download/v1.6.0/boot2docker.iso dev --virtualbox-memory 4096 --virtualbox-disk-size 40000`

3. Make sure Docker machine VM is running, and start if necessary:

  `docker-machine ls`
  `docker-machine start dev`

4. Make sure Docker machine is configured in current shell:

  `eval "$(docker-machine env dev)"`

4. Get the services running:

  `docker-compose up`
