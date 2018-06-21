FROM ruby:2.5.1-slim

LABEL Name=futurelearn-drone
LABEL Version=2.5.1

RUN apt-get update -qq && apt-get install -y \
  apt-transport-https \
  curl \
  gpg \
  && apt-get clean

# Dependency for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Get recent NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash

# mitmproxy
RUN curl -SL https://github.com/mitmproxy/mitmproxy/releases/download/v3.0.4/mitmproxy-3.0.4-linux.tar.gz | tar zxv -C /usr/local/bin

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  chromedriver \
  default-libmysqlclient-dev \
  git \
  imagemagick \
  libgsl0-dev \
  libpq-dev \
  libxml2-dev \
  libxslt-dev \
  mysql-client \
  nodejs \
  phantomjs \
  postgresql-client \
  potrace \
  yarn \
  && apt-get clean
