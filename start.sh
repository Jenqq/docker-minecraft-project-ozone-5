#!/bin/sh

set -e

cd /data

cp -rf /tmp/minecraft/* .
echo "eula=true" > eula.txt


if [[ ! -e server.properties ]]; then
    cp /tmp/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi

if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi

if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

java $JVM_OPTS -Dfml.queryResult=confirm -jar forge-1.12.2-14.23.5.2860.jar nogui
