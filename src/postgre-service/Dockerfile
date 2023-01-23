# For more details, read: https://cadu.dev/creating-a-docker-image-with-database-preloaded/

# dump build stage
FROM postgres:alpine as dumper

COPY /sql/ /docker-entrypoint-initdb.d/

RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV PGDATA=/data

RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

# final build stage
FROM postgres:alpine

COPY --from=dumper /data $PGDATA

COPY /config/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf