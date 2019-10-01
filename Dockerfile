FROM redis
# Author: Matthias Leuffen <m@tth.es> for https://infracamp.org


ENV PRESET="memory_only"
ENV MAXMEMORY="100mb"
ENV MAXMEMORY_POLICY="allkeys-lru"

ENV SNAPSHOT_INTERVAL="60"

RUN apt-get update && apt-get install -y --no-install-recommends gettext && rm -rf /var/lib/apt/lists/*;

ADD / /starter

WORKDIR /data
VOLUME /data
EXPOSE 6379

ENTRYPOINT ["/starter/docker-entrypoint.sh"]
CMD ["redis-server", "/etc/redis.conf"]