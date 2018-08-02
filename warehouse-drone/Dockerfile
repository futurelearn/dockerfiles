FROM ruby:2.5.1-slim

LABEL name="warehouse-ruby"
LABEL version="2.5.1"

ENV LANG     C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL   C.UTF-8

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  git \
  libpq-dev \
  mysql-client \
  postgresql-client \
  jq \
  parallel \
  && apt-get clean
