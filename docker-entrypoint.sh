#!/bin/bash

set -e
echo "Loading Preset '$PRESET' into /etc/redis.conf"

presetFile="/starter/presets/$PRESET.conf"

if [ ! -f $presetFile ]
then
    echo "ERROR: Preset undefined: '$PRESET'"
    echo "Valid presets are: memory_only, aof_snapshots, rdb_snapshots"
    exit 254
fi;

cat /starter/presets/$PRESET.conf | envsubst > /etc/redis.conf

echo "Redis config file is:"
echo "================== /etc/redis.conf ======================"
cat /etc/redis.conf
echo ""
echo "========================================================="

chown -R redis:redis /data


echo "Starting redis..."

exec gosu redis "$@"
