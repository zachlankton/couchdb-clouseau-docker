#!/bin/bash

echo "Waiting 30 seconds before start Clouseau"
sleep 30

/usr/bin/java -server \
     -Xmx2G \
     -Dsun.net.inetaddr.ttl=30 \
     -Dsun.net.inetaddr.negative.ttl=30 \
     -Dlog4j.configuration=file:/opt/clouseau/log4j.properties \
     -XX:OnOutOfMemoryError="kill -9 %p" \
     -XX:+UseConcMarkSweepGC \
     -XX:+CMSParallelRemarkEnabled \
     -classpath '/opt/clouseau/*' \
     com.cloudant.clouseau.Main \
     /opt/clouseau/clouseau.ini

