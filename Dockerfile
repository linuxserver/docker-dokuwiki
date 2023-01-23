# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.17

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
    php81-bz2 \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-gd \
    php81-iconv \
    php81-ldap \
    php81-pdo_mysql \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-pecl-imagick \
    php81-sqlite3 \
    php81-zip && \
  echo "**** install dokuwiki ****" && \
  if [ -z ${DOKUWIKI_RELEASE+x} ]; then \
    DOKUWIKI_RELEASE=$(wget https://download.dokuwiki.org/rss -O - 2>/dev/null | \
      xmlstarlet sel -T -t -v '/rss/channel/item[1]/link' | \
      cut -d'-' -f2-4 | cut -d'.' -f1 ); \
  fi && \
  curl -o \
  /tmp/dokuwiki.tar.gz -L \
    "https://github.com/splitbrain/dokuwiki/archive/release_stable_${DOKUWIKI_RELEASE}.tar.gz" && \
  mkdir -p \
    /app/www/public && \
  tar xf \
    /tmp/dokuwiki.tar.gz -C \
    /app/www/public --strip-components=1 && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    $HOME/.cache \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
