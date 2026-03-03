#!/bin/bash

#Call GC
docker exec -it registry-srv registry garbage-collect /etc/docker/registry/config.yml
