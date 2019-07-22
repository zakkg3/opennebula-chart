#!/bin/sh

cd $(dirname $0)

for image in $(find . -maxdepth 2 -name Dockerfile | awk -F/ '{print $2}'); do
  export DOCKER_BUILDKIT=1
  docker push ${CI_REGISTRY_IMAGE}/$image:${CI_COMMIT_REF_NAME}
done
