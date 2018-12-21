#!/bin/bash

# Author: Bin Wu <bin.wu@elastic.co>

PWD=`pwd`
IPADDR=$(hostname -I | cut -d ' ' -f 1)

[ -d /data/kbn/logs ] || mkdir -p /data/kbn/logs

egrep -lRZ "\%ESHOST\%" /opt/kibana/config/*.yml \
    | xargs -0 -l sed -i -e "s/\%ESHOST\%/$ES_IP/g"
egrep -lRZ "\%ESPORT\%" /opt/kibana/config/*.yml \
    | xargs -0 -l sed -i -e "s/\%ESPORT\%/$ES_PORT/g"

echo -n "Starting kibana ... "

/opt/kibana/bin/kibana \
    --host $IPADDR \
    -p 5601 \
    --pid.file=/data/kbn.pid \
    --path.data=/data/kbn \
    -e http://$ES_IP:$ES_PORT \
    -l /data/kbn/logs/kbn.log
    #-l $PWD/data/kbn/logs/kbn.log > /dev/null 2>&1 &

if [ $? -eq 0 ]
then
    PID=`ps -elf | egrep "kibana" | egrep -v "kbn.sh|grep" | awk '{print $4}'`
    echo "succeed, pid: $PID"
else
    echo "failed."
fi
