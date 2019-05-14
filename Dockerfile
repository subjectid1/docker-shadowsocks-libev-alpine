FROM alpine:latest

ENV RUN_MODE server

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        git \
        autoconf \
        automake \
        build-base \
        c-ares-dev \
        libev-dev \
        libtool \
        libsodium-dev \
        linux-headers \
        mbedtls-dev \
        pcre-dev \
    && cd /tmp \
    && git clone --recursive "https://github.com/shadowsocks/shadowsocks-libev" \
    && cd shadowsocks-libev \
    && ./autogen.sh \
    && ./configure --prefix=/usr --disable-documentation \
    && make install -j4 \
    && apk del --purge .build-deps \
    && apk add --no-cache \
        curl \
        jq \
        rng-tools \
        $(scanelf --needed --nobanner /usr/bin/ss-* \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u) \
    && rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh
COPY checkip.sh /checkip.sh

USER nobody

VOLUME /etc/shadowsocks-libev/config.json

ENTRYPOINT /entrypoint.sh
