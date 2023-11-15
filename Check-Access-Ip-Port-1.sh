#!/bin/bash
clear
DESTINATION=$(cat /home/s.yekta/ip-list.opim | awk '{print $1}')
PORT=$(cat /home/s.yekta/ip-list.opim | awk '{print $3}')
ALLIP=10.10.10.10
for ip in $ALLIP ; do
    for dest in $DESTINATION ; do
        for por in $PORT ; do
            ssh $ip "timeout 2 bash -c \"exec 3<>/dev/tcp/$dest/$por\""
            if [[ "$?" == "0" ]];then
                echo "$ip------->$dest:$por OK"
            else
                echo "$ip------->$dest:$por NOT"
            fi
        done
    done
done