ARG RELEASE_VERSION
ARG IMAGE_NAME="ghcr.io/richardhp/richardhowellpeak_rails:$RELEASE_VERSION"

FROM $IMAGE_NAME as builder

FROM nginx:1.23.1-alpine

COPY --from=builder /app/public /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
