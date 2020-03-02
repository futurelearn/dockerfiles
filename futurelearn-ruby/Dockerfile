ARG RUBY_VERSION=2.6.5

FROM ruby:${RUBY_VERSION}-slim

LABEL name="futurelearn-ruby"
LABEL version=${RUBY_VERSION}

ENV BUNDLER_VERSION="1.17.3"
ENV GEOIPUPDATE_VERSION="4.0.6"

RUN apt-get update -qq && apt-get install -y \
  apt-transport-https \
  curl \
  gpg \
  && apt-get clean

# Dependency for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Get recent NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash

# Fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  clamdscan \
  default-libmysqlclient-dev \
  default-mysql-client \
  git \
  imagemagick \
  libgsl0-dev \
  libpq-dev \
  libssl-dev \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  postgresql-client \
  potrace \
  yarn \
  && apt-get clean

# Geoipupdate package
RUN curl -sSL https://github.com/maxmind/geoipupdate/releases/download/v${GEOIPUPDATE_VERSION}/geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb \
  -o geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb && \
  dpkg -i geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb && \
  rm geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb

# Get latest bundler
RUN gem install bundler --no-document -v $BUNDLER_VERSION

COPY clamd.conf /etc/clamav/clamd.conf
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["irb"]
