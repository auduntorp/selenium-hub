#!/usr/bin/env bash
if [ "$1" == "--help" ]
then
    echo "Start virtual machines serving selenium servers."
    echo "Usage: $(basename $0)"
    exit 1
fi
set -e
cd $(basename $0)
source expand-docker-compose-template.sh template-docker-compose.yml

stop() {
    docker-compose stop
}

trap stop INT
docker-compose build
docker-compose up -d

mkdir -p Tools/selenium_conf
make Tools/selenium_conf/selenium-server-standalone.jar
java -jar Tools/selenium_conf/selenium-server-standalone.jar -hub http://${DOCKER_MACHINE_IP}:4444/grid/register -role node -port 5560 -nodeConfig local-selenium-server-config/safari.json -remoteHost http://${MY_IP}:5560

