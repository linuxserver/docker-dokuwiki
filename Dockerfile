# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.18

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DOKUWIKI_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    xmlstarlet && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    imagemagick \
    php82-bz2 \
    php82-dom \
    php82-gd \
    php82-ldap \
    php82-pdo_mysql \
    php82-pdo_pgsql \
    php82-pdo_sqlite \
    php82-pecl-imagick \
    php82-sqlite3 && \
  echo "**** install dokuwiki ****" && \
  if [ -z ${DOKUWIKI_RELEASE+x} ]; then \
    DOKUWIKI_RELEASE=$(wget https://download.dokuwiki.org/rss -O - 2>/dev/null | \
      xmlstarlet sel -T -t -v '/rss/channel/item[1]/link' | \
      cut -d'-' -f2-4 | cut -d'.' -f1 ); \
  fi && \
  curl -o \
  /tmp/dokuwiki.tar.gz -L \
    "https://download.dokuwiki.org/src/dokuwiki/dokuwiki-${DOKUWIKI_RELEASE}.tgz" && \
  mkdir -p \
    /app/www/public && \
  tar xf \
    /tmp/dokuwiki.tar.gz -C \
    /app/www/public --strip-components=1 && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
