FROM nginx:1.14.0-perl
LABEL maintainer="CS-Tao <whucstao@qq.com>" version="1.0.0"

ENV TZ UTC
ENV LANG C.UTF-8
ENV WEB_REPO_URL https://github.com/CS-Tao/GTD-Visualization.git
ENV WEB_REPO_BRANCH gh-pages
ENV WEB_FOLDER web
ENV WEB_OLD_SRC_URL http://localhost:2001
ENV WEB_NEW_SRC_URL ../

RUN echo "Installing packages ..." \
      # && echo 'deb http://mirrors.ustc.edu.cn/debian jessie main contrib non-free' > /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian jessie main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb http://mirrors.ustc.edu.cn/debian jessie-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian jessie-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb http://mirrors.ustc.edu.cn/debian jessie-updates main contrib non-free' >> /etc/apt/sources.list \
      # && echo 'deb-src http://mirrors.ustc.edu.cn/debian jessie-updates main contrib non-free' >> /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y --no-install-recommends ca-certificates git \
      && mkdir -p /usr/share/nginx/html/ \
      && cd /usr/share/nginx/html/ \
      && git clone ${WEB_REPO_URL} -b ${WEB_REPO_BRANCH} gtd-visualization \
      && cd gtd-visualization/${WEB_FOLDER} \
      && sed -i "s?baseURL:\"${WEB_OLD_SRC_URL}\"?baseURL:\"${WEB_NEW_SRC_URL}\"?" web.js \
      && ls -a -l \
      && apt-get purge -y --auto-remove ca-certificates git \
      && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY django_check.sh /usr/local/bin/django_check.sh
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY start_nginx.sh /usr/local/bin/start_nginx.sh
COPY update_website /usr/local/bin/update_website

RUN chmod +x /usr/local/bin/django_check.sh \
      && chmod +x /docker-entrypoint.sh \
      && chmod +x /usr/local/bin/start_nginx.sh \
      && chmod +x /usr/local/bin/update_website

EXPOSE 8070

WORKDIR /usr/share/nginx/html/

VOLUME ["/usr/share/nginx/html/static", "/var/gtd/django-sock", "/var/gtd/logs"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["echo", "Service stoped."]
