#!/bin/sh
export CI_COMMIT_REF_NAME='5.8.2'
export CI_REGISTRY_IMAGE='zakkg3'
echo '========== Start build =========='
./build.sh
echo '========== Start push =========='
./push.sh
