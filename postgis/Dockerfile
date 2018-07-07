FROM postgres:9.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV PG_DUMPED_DATA_DEFAULT_URL https://github.com/CS-Tao/GTD-Docker/releases/download/v1.0.0/gtdb.sql

ENV POSRGRESQL_MAJOR 9.6

ENV POSTGIS_MAJOR 2.4

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
            ca-certificates \
            wget \
            postgis \
            postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR} \
            postgresql-${POSRGRESQL_MAJOR}-postgis-scripts \
      && apt-get purge -y --auto-remove wget ca-certificates \
      && rm -rf /var/lib/apt/lists/*

COPY create_role.sh /docker-entrypoint-initdb.d/10-create_role.sh
COPY init_db.sh /docker-entrypoint-initdb.d/20-init_db.sh
COPY import_data /usr/local/bin/import_data
COPY _import_data /usr/local/bin/_import_data

RUN   chmod 755 /docker-entrypoint-initdb.d/10-create_role.sh \
      && chmod 755 /docker-entrypoint-initdb.d/20-init_db.sh \
      && chmod +x /usr/local/bin/_import_data \
      && chmod +x /usr/local/bin/import_data \
      && chown -R postgres:postgres /usr/local/bin

VOLUME ["/var/lib/postgresql/data", "/var/gtd/logs"]
