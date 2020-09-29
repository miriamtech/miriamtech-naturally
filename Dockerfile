FROM ubuntu:latest

RUN apt-get update && apt-get install -y ruby
RUN gem install bundler
ADD Gemfile miriamtech-naturally.gemspec /home/app/miriamtech-naturally/
WORKDIR /home/app/miriamtech-naturally
RUN bundle install
