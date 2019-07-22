#!/bin/sh

cd $(dirname $0)

for image in $(find . -maxdepth 2 -name Dockerfile | awk -F/ '{print $2}'); do
  export DOCKER_BUILDKIT=1
  docker build --build-arg VERSION=${CI_COMMIT_REF_NAME} -t ${CI_REGISTRY_IMAGE}/$image:${CI_COMMIT_REF_NAME} --progress plain $image
done
