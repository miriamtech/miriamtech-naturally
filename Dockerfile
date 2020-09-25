FROM ubuntu:latest

RUN apt-get update && apt-get install -y ruby
RUN gem install bundler
ADD Gemfile naturally.gemspec /home/app/naturally/
WORKDIR /home/app/naturally
RUN bundle install
