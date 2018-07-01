FROM postgres:9.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV PG_DUMPED_DATA_URL https://gogs.cs-tao.cc/CS-Tao/GTD-Docker/src/ca3c9f718ed8a2337874f17b7939a59b84071654/postgis/gtdb.sql

ENV POSRGRESQL_MAJOR 9.6

ENV POSTGIS_MAJOR 2.4
# ENV POSTGIS_VERSION 2.4.4+dfsg-4.pgdg+1
# ENV POSTGIS_MD5 929414914e45912643dea3cfb6b59182
# ENV PG_POSTGIS_MD5 3d0abccc84e466ed89e66e17640f9612
# ENV PG_POSTGIS_SCRIPTS_MD5 472fedf2f46176a0a108d98562556d84

# RUN echo "Installing packages ..." \
#       && apt-get update \
#       && apt-get install -y --no-install-recommends ca-certificates wget \
#       && wget -P /tmp https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgis/postgis_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#       && wget -P /tmp https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgis/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#       && wget -P /tmp https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgis/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts_${POSTGIS_VERSION}_all.deb \
#       && apt-get purge -y --auto-remove ca-certificates wget \
#       && (\
#             echo "${POSTGIS_MD5} /tmp/postgis_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb" &&\
#             echo "${PG_POSTGIS_MD5} /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb" &&\
#             echo "${PG_POSTGIS_SCRIPTS_MD5} /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts_${POSTGIS_VERSION}_all.deb" \
#       ) > postgresql.md5 \
#       && md5sum -c postgresql.md5 \
#       && rm -f postgresql.md5 \
#       && (\
#             dpkg -i /tmp/postgis_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#                     /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#                     /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts_${POSTGIS_VERSION}_all.deb \
#             || apt-get install -y --no-install-recommends -f \
#       )\
#       && (\
#             dpkg -i  /tmp/postgis_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#                   /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}_${POSTGIS_VERSION}_$(dpkg --print-architecture).deb \
#                   /tmp/postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts_${POSTGIS_VERSION}_all.deb \
#             || apt-get install -y --no-install-recommends -f \
#       )\
#       && rm -rf /tmp/*.deb \
#       && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
            ca-certificates \
            wget \
            postgis \
            postgresql-${POSRGRESQL_MAJOR}-postgis-${POSTGIS_MAJOR} \
            postgresql-${POSRGRESQL_MAJOR}-postgis-scripts \
      && wget -P /usr/local/bin ${PG_DUMPED_DATA_URL} \
      && apt-get purge -y --auto-remove ca-certificates wget \
      && rm -rf /var/lib/apt/lists/*

COPY create_role.sh /docker-entrypoint-initdb.d/10-create_role.sh
COPY init_db.sh /docker-entrypoint-initdb.d/20-init_db.sh

RUN   chmod 755 /docker-entrypoint-initdb.d/10-create_role.sh \
      && chmod 755 /docker-entrypoint-initdb.d/20-init_db.sh \
      && chmod 755 /usr/local/bin/gtdb.sql \
      && chown -R postgres:postgres /usr/local/bin

VOLUME ["/var/lib/postgresql/data", "/var/gtd/logs"]
