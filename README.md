# The Onion's Docker Services

This is a set of containers that provide basic services for use in development. The idea here is that we have an "onion", "clickhole", "avclub" container each, and those link to these.

## OSX Setup instructions

### Short Version

1. Run ```scripts/init```

2. Setup OSX Docker Shell Enviornment (see below)

### Long Version

1. Install Docker:

        > brew update && brew install docker docker-machine docker-compose

2. Verify you're using docker v1.7+, docker-compose 1.3.1+, docker-machine 0.3.1+

        > docker --version && docker-compose --version && docker-machine --version

3. Create Docker machine VirtualBox VM (recommended 4GB+ RAM, 40GB+ Disk) named *docker-dev*

        > docker-machine create --driver virtualbox --virtualbox-memory 4096 --virtualbox-disk-size 40000 docker-dev

4. Make sure Docker machine VM is running, and start if necessary:

        > docker-machine ls
        > docker-machine start docker-dev

5. **IMPORTANT** Setup docker shell environment variables (more details below). In your shell config (~/.bash_profile, ~/.zshrc, etc.) add this line:

        eval "$(docker-machine env docker-dev)"

6. Reload your shell config (or open a new terminal) to verify docker environment setup (your values may be slightly different):

        > source ~/.bash_profile

        > env | grep DOCKER
        DOCKER_TLS_VERIFY=1
        DOCKER_HOST=tcp://192.168.99.100:2376
        DOCKER_CERT_PATH=/Users/michaelparent/.docker/machine/machines/docker-dev
        DOCKER_MACHINE_NAME=docker-dev

7. Get the Onion services running:

        docker-compose up -d

## OSX Docker Shell Environment

### SUPER IMPORTANT -- READ THIS TO AVOID MANY HEADACHES

On OSX, docker runs inside a VirtualBox **docker-machine** instance (formerly known as **boot2docker**). This extra layer requires some shell environment variables to tie everything together. 

If you do not have these enviroment variables set in your current shell instance, your `docker` and `docker-compose` commands will hang or fail to run, giving very confusing error messages.

**Most issues setting up a new Docker environment are attributed to these environment variables not being setup correctly.**

**HIGHLY RECOMMENDED:** Put the following in your shell config (~/.bash_profile, ~/.zshrc, etc.) to auto-setup each new shell

    eval "$(docker-machine env docker-dev)"

When you startup a new shell, make sure make sure that your shell environment variables matchup with the required values.

    > env | grep DOCKER
    DOCKER_TLS_VERIFY=1
    DOCKER_HOST=tcp://192.168.99.100:2376
    DOCKER_CERT_PATH=/Users/michaelparent/.docker/machine/machines/docker-dev
    DOCKER_MACHINE_NAME=docker-dev

    > docker-machine env docker-dev
    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://192.168.99.100:2376"
    export DOCKER_CERT_PATH="/Users/michaelparent/.docker/machine/machines/docker-dev"
    export DOCKER_MACHINE_NAME="docker-dev"

**Note:** Make sure you're running docker-machine v0.3.1+, otherwise, if your *docker-dev* VM is not running, your new shell will hang on startup while your RC file tries to connect to the (not running) VM to setup the environment variables. This was fixed in v0.3.1 to quickly exit.

## Docker Tips

1. Setup shell aliases for commonly used docker commands

        alias dm=docker-machine

        alias dc=docker-compose

2. If running in background (via "-d" flag), use `docker-compose logs` to view the running container's logs + console output

3. List all running docker containers

        docker ps
