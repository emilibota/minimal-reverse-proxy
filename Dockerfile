FROM caddy:2-alpine

RUN apk add --no-cache libcap \
    && setcap -r /usr/bin/caddy \
    && apk del libcap

COPY Caddyfile /etc/caddy/Caddyfile