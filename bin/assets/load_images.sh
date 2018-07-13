#!/bin/bash
set -e

IMAGE_DIR=`dirname $0`

docker load -i ${IMAGE_DIR}/django/gtd-django.tar
docker load -i ${IMAGE_DIR}/nginx/gtd-nginx.tar
docker load -i ${IMAGE_DIR}/postgis/gtd-postgis.tar
