FROM ruby:3.1.3-alpine

ARG SECRET_KEY_BASE

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

RUN RAILS_ENV=production rails assets:precompile
