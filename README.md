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

5. Make sure Docker machine is configured in current shell.

`eval "$(docker-machine env dev)"`
`env`

You should see "DOCKER_HOST" listed as an environment variable

6. RECOMMENDED: Add this to your `~/.bash_profile` or similar to auto-configure your shell enviroment to know about your Docker VM

`eval "$(docker-machine env dev)"`

and then reload your config in current shell (any of ~/.bashrc, ~/.bash_profile, ~/.zshrc, etc):

`source ~/.bash_profile`

7. Get the Onion services running:

`docker-compose up -d`
