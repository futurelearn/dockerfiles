FROM ubuntu:14.04
ENV ES_VERSION=5.1.2

RUN apt-get -qq update && apt-get install -y \
  apt-transport-https \
  curl \
  software-properties-common \
  wget

# Ruby
RUN apt-add-repository -y ppa:brightbox/ruby-ng

# Java
RUN add-apt-repository -y ppa:webupd8team/java && \
  echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash

# Elasticsearch
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
  echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

# mitmproxy
RUN curl -SL https://github.com/mitmproxy/mitmproxy/releases/download/v3.0.4/mitmproxy-3.0.4-linux.tar.gz \
  | tar zxv -C /usr/local/bin

RUN apt-get -qq update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  chromium-browser \
  chromium-chromedriver \
  elasticsearch=$ES_VERSION \
  git \
  imagemagick \
  libgsl0-dev \
  libmysqlclient-dev \
  libpq-dev \
  libxml2-dev \
  libxslt-dev \
  mysql-server-5.6 \
  nodejs \
  oracle-java8-installer \
  postgresql-client \
  potrace \
  redis-server \
  ruby2.5 \
  ruby2.5-dev \
  tzdata \
  yarn

RUN gem install bundler --no-document
