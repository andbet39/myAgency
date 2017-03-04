FROM ruby:2.3-alpine

MAINTAINER Andrea Terzani <andrea.terzani@gmail.com>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs"

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES

ENV INSTALL_PATH /myAgency

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

#RUN node -v
#RUN npm install -g webpack
#RUN npm install -g foreman
#RUN npm install -g yarn



COPY Gemfile Gemfile.lock ./
COPY package.json ./
COPY . .

RUN bundle config build.nokogiri --use-system-libraries && bundle install

#RUN yarn


VOLUME ["$INSTALL_PATH/public"]

CMD  rails s
