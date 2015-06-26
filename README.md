# The Onion's Docker Services

This is a set of containers that provide basic services for use in development. The idea here is that we have an "onion", "clickhole", "avclub" container each, and those link to these.

## OSX Setup instructions

1. Install Docker:

    `brew update && brew install docker docker-machine docker-compose`

2. Verify you're using docker v1.7+, docker-compose 1.3.1+, docker-machine 0.3.0+

    `docker --version`
    `docker-compose --version`
    `docker-machine --version`

3. Create Docker machine VirtualBox VM (recommended at least 4GB RAM, 40GB HD). For example, to create machine named 'docker':

    `docker-machine create --driver virtualbox --virtualbox-memory 4096 --virtualbox-disk-size 40000 dev`

4. Make sure Docker machine VM is running, and start if necessary:

    `docker-machine ls`
    `docker-machine start dev`

5. Make sure Docker machine is configured in current shell by running:

    `eval "$(docker-machine env dev)"`
    `env`

You should see "DOCKER_HOST" listed as an environment variable

7. Get the Onion services running:

    `docker-compose up -d`

## OSX Docker Shell Environment

On OSX, docker runs inside a VirtualBox "docker-machine / boot2docker" instance. This extra layer requires some shell environment variables to tie everything together. If you do not have these enviroment variables set in your current shell instance, your `docker` and `docker-compose` commands will fail.

1. The necessary docker environment variables can be printed via:

    `docker-machine env docker-dev`

2. You can add these to your current shell instance via

    `eval $(docker-machine env dev)`

**Recommended:** Put this in your shell config (~/.bash_profile, ~/.bashrc, ~/.zshrc, etc.) to auto-setup each new shell

**Note:** If your docker-machine VirtualBox VM is not running, this command will hang for a while before timeing out, which can be very annoying when starting a new shell. Hopefullly this will be fixed by docker-machine in the future, but having this stuff auto initialized in your shell is worth the tradeoff. I would add this step to the end of your config file so if it does hang, you can CTRL-C and still have sourced everything else in the config file.

## Docker Tips

1. Setup shell aliases for commonly used docker commands

    `alias dm=docker-machine`

    `alias dc=docker-compose`

2. If running in background (via "-d" flag), use `docker-compose logs` to view the running container's logs + console output
