#!/usr/bin/env bash
if [ "$#" -ne "2" ]
then
    echo "Usage: $(basename $0) <type> <port>"
    exit 1
fi
if [ -z "$DOCKER_MACHINE_NAME" ]; then
    DOCKER_MACHINE_NAME=default
fi
VBoxManage modifyvm $DOCKER_MACHINE_NAME --natpf1 "${1}-port${2},${1},,${2},,${2}"
