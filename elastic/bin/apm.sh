#!/bin/bash

# Author: Bin Wu <bin.wu@elastic.co>

PWD=`pwd`
IPADDR=$(hostname -I | cut -d ' ' -f 1)

egrep -lRZ "\%ESHOST\%" /opt/apm_server/*.yml \
    | xargs -0 -l sed -i -e "s/\%ESHOST\%/$ES_IP/g"
egrep -lRZ "\%ESPORT\%" /opt/apm_server/*.yml \
    | xargs -0 -l sed -i -e "s/\%ESPORT\%/$ES_PORT/g"
egrep -lRZ "\%KBNHOST\%" /opt/apm_server/*.yml \
    | xargs -0 -l sed -i -e "s/\%KBNHOST\%/$KBN_IP/g"
egrep -lRZ "\%KBNPORT\%" /opt/apm_server/*.yml \
    | xargs -0 -l sed -i -e "s/\%KBNPORT\%/$KBN_PORT/g"

/opt/apm_server/apm-server \
    -c $CONF_FILE \
    -E setup.kibana.host=$KBN_IP:$KBN_PORT \
    setup

echo -n "Starting apm ... "

/opt/apm_server/apm-server \
    -e -c $CONF_FILE \
    -E output.elasticsearch.hosts=$ES_IP:$ES_PORT \
    -E apm-server.host=$IPADDR:8200 \
    -E logging.to_files=true \
    -E logging.files.path=/opt/apm_server/logs

if [ $? -eq 0 ]
then
    PID=`ps -elf | egrep "apm" | egrep -v "apm.sh|grep" | awk '{print $4}'`
    echo "succeed, pid: $PID"
else
    echo "failed."
fi

