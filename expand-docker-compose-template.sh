#!/usr/bin/env bash
if [ "$1" == "--help" ] || [ -z "$1" ]
then
    echo 'Substitutes ${PUBLIC_IP} in the input with the ip where docker is running.'
    echo "Usage: $(basename $0) <input-file>"
    exit 1
fi
source find_docker_ip.sh
set -e
sed s/\$\{PUBLIC_IP\}/$DOCKER_MACHINE_IP/g "$1" > docker-compose.yml
