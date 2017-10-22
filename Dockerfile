FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /door2door_app
WORKDIR /door2door_app
ADD Gemfile /door2door_app/Gemfile
ADD Gemfile.lock /door2door_app/Gemfile.lock
RUN bundle install
ADD . /door2door_app
