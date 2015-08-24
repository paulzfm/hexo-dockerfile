FROM nginx
MAINTAINER Stephen Liang "docker-maint@stephenliang.pw"

ADD default.conf /etc/nginx/conf.d/default.conf

ENV HEXO_VERSION 2.8.3

# Grab dependencies
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup | bash - && apt-get update && apt-get install -y curl git nodejs
RUN npm install -g hexo@${HEXO_VERSION}

# Create hexo base files
RUN hexo init /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN npm install
RUN npm install hexo-renderer-marked@0.1
RUN npm install hexo-renderer-stylus@0.1

VOLUME /usr/share/nginx/html/source

CMD hexo generate && nginx -g "daemon off;"
