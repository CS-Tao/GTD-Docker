#!/bin/bash
set -e

if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname='${POSTGRES_DATABASE}'" )" = '1' ]; then
    echo "Database ${POSTGRES_DATABASE} has already existed."
else
    sed -i "1s/^/\\\connect ${POSTGRES_DATABASE}\n/" /usr/local/bin/gtdb.sql
    psql -tc "CREATE DATABASE ${POSTGRES_DATABASE} WITH OWNER = ${POSTGRES_USER}"
    psql -v gtdb_user=${POSTGRES_USER} -f /usr/local/bin/gtdb.sql
    echo "Data imported to ${POSTGRES_DATABASE}"
fi
