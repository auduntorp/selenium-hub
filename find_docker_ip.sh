#!/usr/bin/env bash
if which docker-compose
then
    if [ -z "$DOCKER_MACHINE_NAME" ]
    then
        echo "DOCKER_MACHINE_NAME not set, using default"
        DOCKER_MACHINE_NAME=default
    fi
    DOCKER_MACHINE_IP=$(docker-machine ip ${DOCKER_MACHINE_NAME})
    MY_IP=$(echo $DOCKER_MACHINE_IP | awk -F . '{print $1 "." $2 "." $3 ".1"}')
else
    echo "Did not find docker-machine. using localhost"
    DOCKER_MACHINE_IP=localhost
    MY_IP=localhost
fi
