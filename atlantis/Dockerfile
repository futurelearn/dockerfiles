FROM runatlantis/atlantis:latest

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    && echo 'gem: --no-document' > /etc/gemrc

RUN gem install aws-sdk-s3 webrick # webrick required by S3 gem
