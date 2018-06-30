#!/bin/bash
set -e

cp /opt/settings.py /opt/GTD-Background/terrorism_rear_end/settings.py
cp /opt/uwsgi.ini /opt/GTD-Background/uwsgi.ini

if [ ! -d "/var/gtd/logs/django-uwsgi/" ];then
    mkdir /var/gtd/logs/django-uwsgi
else
    echo "Directory '/var/gtd/logs/django-uwsgi' has already existed."
    if [ ! -f "/data/filename" ];then
        touch /var/gtd/logs/django-uwsgi/gtd_uwsgi.log
    else
        echo "File '/var/gtd/logs/django-uwsgi/gtd_uwsgi.log' has already existed."
    fi
fi

cat >> /opt/GTD-Background/terrorism_rear_end/settings.py << EOF

# Database
# https://docs.djangoproject.com/en/2.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'NAME': '$POSTGRES_DATABASE',
        'USER': '$POSTGRES_USER',
        'HOST': '$POSTGRES_HOST',
        'PORT': '$POSTGRES_PORT',
        'PASSWORD': '$POSTGRES_PASSWD',
    }
}

EOF

rm -rf /opt/gtddjango/static/*

# python manage.py migrate

python manage.py collectstatic

# python manage.py runserver 0.0.0.0:8080

exec "$@";
