#!/bin/bash


docker build . -t infracamp/redis

docker run -it -e PRESET=rdb_snapshots infracamp/redis