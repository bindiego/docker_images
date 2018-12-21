#!/bin/bash

# Author: Bin Wu <bin.wu@elastic.co>

PWD=`pwd`
JAVA=`which java`
IPADDR=$(hostname -I | cut -d ' ' -f 1)

echo -n "Starting elasticsearch ... "

ES_JAVA_OPTS="-Xms$ES_HEAP -Xmx$ES_HEAP -XX:-UseConcMarkSweepGC -XX:-UseCMSInitiatingOccupancyOnly -XX:+UseG1GC -XX:InitiatingHeapOccupancyPercent=75" \
    /opt/elasticsearch/bin/elasticsearch \
    -p /opt/es.pid \
    -Ecluster.name=bindigo \
    -Enode.name=tiger \
    -Epath.data=/data/es \
    -Epath.logs=/data/es/logs \
    -Enetwork.host=0.0.0.0
    #-Expack.security.transport.ssl.enabled=true \
    #-Expack.security.transport.ssl.verification_mode=certificate \
    #-Expack.security.transport.ssl.keystore.path=certs/elastic-certificates.p12 \
    #-Expack.security.transport.ssl.truststore.path=certs/elastic-certificates.p12
    #-Ebootstrap.memory_lock=true
    #-d -p /opt/es.pid \

if [ $? -eq 0 ]
then
    PID=`ps -elf | egrep "elasticsearch" | egrep -v "es.sh|grep" | awk '{print $4}'`
    echo "succeed, pid: $PID"
else
    echo "failed."
fi

