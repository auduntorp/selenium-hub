#!/usr/bin/env bash
if [ "$#" -ne "1" ]
then
    INTERFACE=en0
elif [ "$1" == "--help" ]
then
    echo "Start virtual machines serving selenium servers."
    echo ""
    echo "Mac users needs to give their public ip to the docker containers to be discoverable. This is picked from the interface. Default interface is en0"
    echo "Usage: $(basename $0) [<interface>]"
    exit 1
else
    INTERFACE=$1
fi
set -e
PUBLIC_IP=$(ifconfig $INTERFACE | grep 'inet ' | awk '{print $2}')
sed s/\$\{PUBLIC_IP\}/$PUBLIC_IP/g template-docker-compose.yml > docker-compose.yml

stop() {
    docker-compose stop
}

trap stop INT
docker-compose build
docker-compose up -d

mkdir -p Tools/selenium_conf
make Tools/selenium_conf/selenium-server-standalone.jar
java -jar Tools/selenium_conf/selenium-server-standalone.jar -hub http://${PUBLIC_IP}:4444/grid/register -role node -port 5560 -nodeConfig local-selenium-server-config/safari.json -remoteHost http://${PUBLIC_IP}:5560

