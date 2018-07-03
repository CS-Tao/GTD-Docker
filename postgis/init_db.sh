#!/bin/bash
set -e

if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname='${POSTGRES_DB}'" )" = '1' ]; then
    echo "Database ${POSTGRES_DB} has already existed."
else
    psql -tc "CREATE DATABASE ${POSTGRES_DB} WITH OWNER = ${POSTGRES_USER}"
fi
