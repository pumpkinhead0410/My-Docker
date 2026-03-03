#!/bin/bash

REGISTRY_ENDPOINT="${REGISTRY_ENDPOINT:-<registry_host>:5000}"

if [ -n "$1" ] && [ -n "$2" ]
then
  echo "image = $1"
  echo "tag = $2"

  #Get docker-content-digest
  DIGEST=$(curl -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -X GET ${REGISTRY_ENDPOINT}/v2/$1/manifests/$2 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}')
  echo "docker-content-digest = $DIGEST"
  #Delete
  echo "curl -X DELETE ${REGISTRY_ENDPOINT}/v2/$1/manifests/$DIGEST"

  ADDRESS=${REGISTRY_ENDPOINT}/v2/$1/manifests/$DIGEST

  URL=$(echo $ADDRESS | tr -d '\r')

  curl -X DELETE $URL

  curl -X GET ${REGISTRY_ENDPOINT}/v2/$1/tags/list

else
  echo "No parameters passed"
fi
