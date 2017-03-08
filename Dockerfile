FROM ruby:2.3-alpine

MAINTAINER Andrea Terzani <andrea.terzani@gmail.com>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json nodejs"

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES

ENV INSTALL_PATH /myAgency
ENV RAILS_ENV=production

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH


COPY Gemfile Gemfile.lock ./
COPY package.json ./
COPY . .

RUN bundle config build.nokogiri --use-system-libraries && bundle install
RUN rails db:migrate
RUN rails db:seed
RUN rails assets:precompile

VOLUME ["$INSTALL_PATH/public"]

CMD  rails s
