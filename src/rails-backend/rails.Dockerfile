FROM ruby:3.0.2 as builder

ARG SECRET_KEY_BASE

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

RUN RAILS_ENV=production rails assets:precompile
