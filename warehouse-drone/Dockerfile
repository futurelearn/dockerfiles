FROM ruby:2.5.3-slim

LABEL name="warehouse-ruby"
LABEL version="2.5.3"

ENV LANG     C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL   C.UTF-8

# Fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  git \
  libpq-dev \
  mysql-client \
  postgresql-client \
  gawk \
  jq \
  parallel \
  python3-pip \
  && apt-get clean
