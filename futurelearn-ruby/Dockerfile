ARG RUBY_VERSION=2.6.5

FROM ruby:${RUBY_VERSION}-slim

LABEL name="futurelearn-ruby"
LABEL version=${RUBY_VERSION}

ENV BUNDLER_VERSION="1.17.3"
ENV GEOIPUPDATE_VERSION="4.3.0"

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
  netcat-traditional \
  postgresql-client \
  potrace \
  && apt-get clean

# Geoipupdate package
RUN apt-get install -y curl && \
  curl -sSL https://github.com/maxmind/geoipupdate/releases/download/v${GEOIPUPDATE_VERSION}/geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb \
  -o geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb && \
  dpkg -i geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb && \
  rm geoipupdate_${GEOIPUPDATE_VERSION}_linux_amd64.deb && \
  apt-get purge -y curl && \
  apt-get autoremove -y && \
  apt-get clean

# Get latest bundler
RUN gem install bundler --no-document -v $BUNDLER_VERSION

COPY clamd.conf /etc/clamav/clamd.conf
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["irb"]
