#!/usr/bin/env bash
if [ "$1" == "--help" ]
then
    echo "Start virtual machines serving selenium servers."
    echo "Usage: $(basename $0)"
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
sed s/\$\{PUBLIC_IP\}/$DOCKER_MACHINE_IP/g template-docker-compose.yml > docker-compose.yml

stop() {
    docker-compose stop
}

trap stop INT
docker-compose build
docker-compose up -d

mkdir -p Tools/selenium_conf
make Tools/selenium_conf/selenium-server-standalone.jar
java -jar Tools/selenium_conf/selenium-server-standalone.jar -hub http://${DOCKER_MACHINE_IP}:4444/grid/register -role node -port 5560 -nodeConfig local-selenium-server-config/safari.json -remoteHost http://${MY_IP}:5560

