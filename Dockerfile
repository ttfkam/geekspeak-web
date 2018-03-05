FROM alpine
MAINTAINER Miles Elam <miles@geekspeak.org>

EXPOSE 80 81

STOPSIGNAL SIGTERM


RUN mkdir -p /run/nginx && \
    apk update && \
    apk add nginx \
            nginx-mod-http-lua-upstream \
            nginx-mod-http-lua \
            nginx-mod-rtmp \
            nginx-mod-http-echo \
            nginx-mod-http-set-misc \
            nginx-mod-http-image-filter \
            nginx-mod-http-nchan \
            nginx-mod-http-cache-purge \
            nginx-mod-http-fancyindex \
            nginx-mod-http-geoip \
            nginx-mod-http-headers-more
#            pgbouncer

#            nginx-mod-http-xslt-filter \
#            nginx-mod-stream \
#            nginx-mod-stream-geoip \
#            nginx-mod-http-redis2 \

COPY docroot /var/www/docroot
COPY nginx /etc/nginx/conf.d
# COPY pgbouncer /etc/pgbouncer

ADD https://raw.githubusercontent.com/Olivine-Labs/lustache/master/src/lustache.lua /usr/local/lua/
ADD https://raw.githubusercontent.com/Olivine-Labs/lustache/master/src/lustache/context.lua /usr/local/lua/lustache/
ADD https://raw.githubusercontent.com/Olivine-Labs/lustache/master/src/lustache/renderer.lua /usr/local/lua/lustache/
ADD https://raw.githubusercontent.com/Olivine-Labs/lustache/master/src/lustache/scanner.lua /usr/local/lua/lustache/

ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon.lua /usr/local/lua/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/arrays.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/crypto.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/hstore.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/init.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/json.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/socket.lua /usr/local/lua/pgmoon/
ADD https://raw.githubusercontent.com/ttfkam/pgmoon/integration/pgmoon/util.lua /usr/local/lua/pgmoon/

# CMD su-exec pgbouncer pgbouncer /etc/pgbouncer/pgbouncer.ini && nginx -g daemon off
CMD nginx -g "daemon off;"
