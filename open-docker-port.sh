#!/usr/bin/env bash
if [ "$#" -ne "2" ]
then
    echo "Usage: $(basename $0) <type> <port>"
    exit 1
fi
VBoxManage modifyvm default --natpf1 "${1}-port${2},${1},,${2},,${2}"
