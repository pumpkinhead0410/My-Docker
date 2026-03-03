#!/bin/sh
docker stop registry-web
docker rm registry-web
docker stop registry-srv
docker rm registry-srv
