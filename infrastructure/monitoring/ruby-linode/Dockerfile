FROM ruby:3.0.2

COPY Gemfile* ./
RUN bundle install 

COPY main.rb .
RUN mkdir ./src
COPY ./src/*.rb ./src/
