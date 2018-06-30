FROM python:3.6
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV LANG C.UTF-8
ENV TZ UTC
ENV DJANGO_REPO_URL https://github.com/RS-GIS-Geeks/GTD-Background.git
ENV DJANGO_REPO_BRANCH docker-assets

RUN echo "Installing packages ..." \
      # && sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list \
      # && sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y --no-install-recommends libgdal-dev git \
      && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
      && git clone ${DJANGO_REPO_URL} -b ${DJANGO_REPO_BRANCH} GTD-Background \
      && cd GTD-Background \
      && ls -a -l \
      && pip install -r requirements.txt \
      && pip3 install https://github.com/darklow/django-suit/tarball/v2

COPY docker-uwsgi-entrypoint.sh /docker-uwsgi-entrypoint.sh
COPY settings.py /opt/settings.py
COPY gtd_uwsgi.ini /opt/uwsgi.ini

RUN chmod +x /docker-uwsgi-entrypoint.sh

ENV PYTHONHOME /usr/local
ENV PYTHONPATH /usr/local/lib/python3.6

WORKDIR /opt/GTD-Background

VOLUME ["/opt/gtddjango/static" ,"/var/gtd/uwsgi-sock", "/var/gtd/logs"]

ENTRYPOINT ["/docker-uwsgi-entrypoint.sh"]

CMD ["uwsgi", "--ini", "uwsgi.ini"]
