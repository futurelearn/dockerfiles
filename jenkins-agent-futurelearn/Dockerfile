FROM jenkins/jnlp-slave

# Switch to root to set everything up
USER root

ENV RUBY_VERSION=2.6.5

WORKDIR /opt

# Install Ruby version we want using ruby-build
RUN apt-get update -qq && \
  apt-get install -y \
  apt-transport-https \
  autoconf \
  bison \
  build-essential \
  curl \
  libffi-dev \
  libgdbm3 \
  libncurses5-dev \
  libreadline6-dev \
  libssl-dev \
  libyaml-dev \
  zlib1g-dev \
  libgdbm-dev && \
  git clone https://github.com/rbenv/ruby-build.git && \
  PREFIX=/usr/local ./ruby-build/install.sh && \
  ruby-build $RUBY_VERSION /opt/ruby-$RUBY_VERSION && \
  apt-get clean

ENV PATH /opt/ruby-$RUBY_VERSION/bin:$PATH

RUN gem install bundler

# don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1 BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $GEM_HOME/bin:$PATH

# Dependency for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Get recent NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash

# Fix for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199
RUN for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done && \
  apt-get update -qq && apt-get install -y \
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
  zip \
  && apt-get clean

USER jenkins
WORKDIR /home/jenkins
