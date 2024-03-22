ARG FUTHORC_PROFILE=release

FROM weberc2/futhorc:0.1.11

ARG FUTHORC_PROFILE

WORKDIR /workspace

COPY . .

RUN futhorc build --profile ${FUTHORC_PROFILE} --output /blog

FROM caddy:2.4.5
ARG FUTHORC_PROFILE

COPY --from=0 /blog /usr/share/caddy
COPY --from=0 /workspace/${FUTHORC_PROFILE}.Caddyfile /etc/caddy/Caddyfile

CMD caddy run --config /etc/caddy/Caddyfile
