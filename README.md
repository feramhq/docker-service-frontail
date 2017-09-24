# Docker Service Frontail

Feed frontail with your Docker Swarm logs and post-process with Bunyan


## Getting started

1. `docker run -it -v  /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:9001:9001 feramhq/docker-service-frontail`
2. Open http://YOUR_MANAGER_NODE:9001


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
```

Deploy the above `docker-compose.yaml` file with:

`docker stack deploy -c docker-compose.yaml devops`
