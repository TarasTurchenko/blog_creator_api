FROM ruby:2.5.1
RUN mkdir /myapp
WORKDIR /myapp

RUN apt-get update -y && apt-get install -y openjdk-8-jre

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN npm i -g yarn

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
