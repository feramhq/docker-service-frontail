# Docker Service Frontail

[![Build Status](https://travis-ci.org/feramhq/docker-service-frontail.svg?branch=master)](https://travis-ci.org/feramhq/docker-service-frontail)

Feed frontail with your Docker Swarm logs and post-process with Bunyan


## Getting Started

1. `docker run -it -v  /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:9001:9001 feramhq/docker-service-frontail`
2. Open http://127.0.0.1:9001


## Creating a Docker Service

Create the following `docker-compose.yaml` file.

```yaml
version: '3.2'
services:
  frontail:
    image: feramhq/docker-service-frontail
    ports:
      - 9001:9001
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    deploy:
      placement:
        constraints:
          - node.role == manager
      resources:
        limits:
          memory: 200M
        reservations:
          memory: 80M
```

Deploy the above `docker-compose.yaml` file with:

`docker stack deploy -c docker-compose.yaml devops`

Note, it is not advisable to deploy this service on more than one node,
because you have to take care of client stickiness on for the websocket connection.
