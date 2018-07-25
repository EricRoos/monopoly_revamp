FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.21.0/geckodriver-v0.21.0-linux64.tar.gz
RUN wget https://ftp.mozilla.org/pub/firefox/releases/61.0b9/linux-x86_64/en-US/firefox-61.0b9.tar.bz2
RUN tar -xvzf geckodriver-v0.21.0-linux64.tar.gz -C /bin
RUN tar xvfj firefox-61.0b9.tar.bz2
RUN mkdir monopoly/
WORKDIR /monopoly
COPY Gemfile /monopoly/Gemfile
COPY Gemfile.lock /monopoly/Gemfile.lock
RUN bundle install
COPY . /monopoly
