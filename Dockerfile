ARG PROFILE

FROM weberc2/futhorc

ARG SITE_ROOT

WORKDIR /workspace

COPY . .

RUN LOG_LEVEL=debug futhorc --site-root ${SITE_ROOT}

FROM caddy:2.9.1
ARG PROFILE

COPY --from=0 /workspace/_output /usr/share/caddy
COPY --from=0 /workspace/${PROFILE}.Caddyfile /etc/caddy/Caddyfile

CMD caddy run --config /etc/caddy/Caddyfile
