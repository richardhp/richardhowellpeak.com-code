ARG SECRET_KEY_BASE
ARG RELEASE_VERSION

FROM ghcr.io/richardhp/richardhowellpeak_rails:${RELEASE_VERSION} as builder

FROM nginx:1.23.1-alpine

COPY --from=builder /app/public /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
