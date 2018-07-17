FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir monopoly/
WORKDIR /monopoly
COPY Gemfile /monopoly/Gemfile
COPY Gemfile.lock /monopoly/Gemfile.lock
RUN bundle install
COPY . /monopoly
