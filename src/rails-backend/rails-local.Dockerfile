FROM ruby:3.0.2 as builder

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
