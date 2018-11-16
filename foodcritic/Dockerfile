FROM ruby:2.5.3-alpine

RUN apk add --update build-base

RUN gem install foodcritic --no-document

ENTRYPOINT [ "foodcritic" ]
