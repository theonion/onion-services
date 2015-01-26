# The Onion's Docker Services

This is a set of containers that provide basic services for use in development. The idea here is that we have an "onion", "clickhole", "avclub" container each, and those link to these.

## To get started:

1. Install Docker (and boot2docker)

2. Make sure boot2docker is running, and configured: `boot2docker up && $(boot2docker shellinit)`

3. Install `docker-compose`: `sudo pip install -U docker-compose`

4. Get the services running: `docker-compose up`