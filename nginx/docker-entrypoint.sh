#!/bin/bash
set -e

if [ ! -d "/var/gtd/logs/nginx/" ];then
    mkdir /var/gtd/logs/nginx
else
    echo "Directory '/var/gtd/logs/nginx' has already existed."
fi

/usr/local/bin/django_check.sh
/usr/local/bin/start_nginx.sh

exec "$@";
