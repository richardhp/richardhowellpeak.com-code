FROM instrumentisto/flutter AS builder

RUN mkdir /app
COPY ./ /app
WORKDIR /app
RUN dart pub get
RUN flutter build web

FROM nginx

COPY --from=builder /app/build/web /usr/share/nginx/html
