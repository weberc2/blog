ARG BUILDPLATFORM

FROM --platform=${BUILDPLATFORM} caddy:2.1.1-alpine

COPY Caddyfile /etc/caddy/Caddyfile

COPY ./site /srv
