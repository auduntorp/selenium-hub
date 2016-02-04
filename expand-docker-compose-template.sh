#!/usr/bin/env bash
if [ "$1" == "--help" ] || [ -z "$1" ]
then
    echo 'Substitutes the public ip of current docker-machine where ${PUBLIC_IP} is in input.'
    echo "Usage: $(basename $0) <input-file>"
    exit 1
fi
if [ -z "$DOCKER_MACHINE_NAME" ]
then
    echo "DOCKER_MACHINE_NAME not set, using default"
    DOCKER_MACHINE_NAME=default
fi
set -e
DOCKER_MACHINE_IP=$(docker-machine ip ${DOCKER_MACHINE_NAME})
MY_IP=$(echo $DOCKER_MACHINE_IP | awk -F . '{print $1 "." $2 "." $3 ".1"}')
sed s/\$\{PUBLIC_IP\}/$DOCKER_MACHINE_IP/g "$1" > docker-compose.yml
