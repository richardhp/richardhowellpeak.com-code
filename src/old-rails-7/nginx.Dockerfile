FROM ruby:3.0.2 as builder

ARG SECRET_KEY_BASE

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

RUN RAILS_ENV=production rails assets:precompile

FROM nginx:1.23.1-alpine

COPY --from=builder /app/public /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
