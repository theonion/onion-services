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

        > docker-machine create --driver virtualbox --virtualbox-cpu-count 2 --virtualbox-memory 5120 --virtualbox-disk-size 50000 --engine-opt dns=8.8.8.8 --engine-opt dns=8.8.4.4 docker-dev

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

## Elasticsearch

If you want to use the `onion-services` elasticsearch locally, such as when developing `django-bulbs`, you'll need to forward port `9200` in virtualbox.

It's a couple menus deep. Select the `docker-dev` box in the VirtualBox UI. Click `settings` > `network` > `Port Forwarding`. Configure like this:

<img src="https://www.evernote.com/shard/s636/sh/77aad7da-ad00-4eb8-b479-c2ffc6afb46d/9f36e3e87c6a12dc/res/44a02631-9bab-4510-add4-bfa33b8c2ca8/skitch.png" />

## Vault

To interact with onion-services Vault:

1. Start vault shell:

        $ docker run -e VAULT_ADDR=http://vault:8201 -it --link onionservices_vault_1:vault --entrypoint=/bin/sh sjourdan/vault

1. Authenticate via default root token (created via docker-compose container script)

        $ vault auth 001fdd19-468b-ef28-c256-b46684c0a6fa
        Successfully authenticated!
        token: 001fdd19-468b-ef28-c256-b46684c0a6fa
        token_duration: 0
        token_policies: [root]

1. Write secret

        $ vault write secret/one hello=world
        Success! Data written to: secret/one

1. Read secret

        $ vault read secret/one
        Key             Value
        lease_duration  2592000
        hello           world

