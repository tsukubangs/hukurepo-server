FROM ruby:2.4.0
ENV LANG C.UTF-8
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs mysql-client

# Rails App
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app
RUN mkdir -p tmp/sockets

RUN rails assets:clean RAILS_ENV=production
RUN rails assets:precompile RAILS_ENV=production

# Expose volumes to frontend
VOLUME /app/public
VOLUME /app/public/assets
VOLUME /app/tmp

# Start Server
CMD  ["bin/entry"]
