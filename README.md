# Infracamp Redis container

This container is build upon the official `redis`-container. But it offers two extensions:

- It runs as non-root user by default
- It is easily configurable by environment variables (eg. in a docker stack)
- It comes with presets for
    - In Memory only usage
    - Snapshot usage
    - AOF Logfiles

## Presets available

See the examples below on how to use the container. The container will be rebuild 
daily (:testing) or weekly (:latest).

Make sure no ports are exposed to the outside world - no security configuration is
available. It is considered for stack-inside use only.

### Configuration for all presets

| Environment Variable   | default          | description |
|------------------------|------------------|-------------|
| `MEMORYLIMIT`          | 100mb            | The total Memory Limit |
| `MAXMEMORY_POLICY`     | allkeys-lru      | Remove key by last resource usage |


Example for your stack-file to spin up a memory only redis instance with 100mb 
memory limit.



### Memory Only (Caches, etc)

- [Redis Documentation about persistence](https://redis.io/topics/persistence)
- [Config file preset](presets/memory_only.conf)

No persistence to disk. Usage for caching / volatile data only.

```yaml
services:
  redis:
    image: infracamp/redis
    environment:
      - PRESET=memory_only
      - MEMORYLIMIT=500mb
```




### RDB Snapshot Persistence (Session storage)

- [Redis Documentation about persistence](https://redis.io/topics/persistence)
- [Config file preset](presets/rdb_snapshots.conf)

The Memory is snapshotted at specified interval to the disk. RDB is very compact
and very perfomant. But you might loose between two snapshots 

| Environment Variable | default | description |
|----------------------|---------|-------------|
| `SNAPSHOT_INTERVAL     | 60            | Make snapshot every 60 seconds |


> Redis data is stored to `/data` inside the container. Make sure you have
> a volume mounted there - otherwise the data will be lost after restart.

Example:

```yaml
services:
  redis:
    image: infracamp/redis
    environment:
      - PRESET=rdb_snapshots
      - MEMORYLIMIT=500mb
      - SNAPSHOT_INTERVAL=30
    volumes:
      - redisVolume:/data
```


### Append-only file persistence (AOF)

