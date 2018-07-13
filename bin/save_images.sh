#!/bin/bash
set -e

DOCKER_USER=cstao
DJANGO_TAG=1.0.0
NGINX_TAG=1.1.0
POSTGIS_TAG=1.0.0
DIST_DIR=`dirname $0`/../dist

mkdir -p ${DIST_DIR}/django
mkdir -p ${DIST_DIR}/nginx
mkdir -p ${DIST_DIR}/postgis
rm -f ${DIST_DIR}/django/*.tar
rm -f ${DIST_DIR}/nginx/*.tar
rm -f ${DIST_DIR}/postgis/*.tar

echo "Saving django..."
docker save -o ${DIST_DIR}/django/gtd-django.tar ${DOCKER_USER}/gtd-django:${DJANGO_TAG}
echo "Saving nginx..."
docker save -o ${DIST_DIR}/nginx/gtd-nginx.tar ${DOCKER_USER}/gtd-nginx:${NGINX_TAG}
echo "Saving postgis..."
docker save -o ${DIST_DIR}/postgis/gtd-postgis.tar ${DOCKER_USER}/gtd-postgis:${POSTGIS_TAG}

echo "Copy scripts..."
cp `dirname $0`/assets/* ${DIST_DIR}/
cp `dirname $0`/../.env ${DIST_DIR}/.env
cp `dirname $0`/../docker-compose.yml ${DIST_DIR}/docker-compose.yml
cp `dirname $0`/../README.md ${DIST_DIR}/README.md

echo "Done."
