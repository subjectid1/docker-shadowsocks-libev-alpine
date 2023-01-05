FROM alpine:latest AS builder

RUN set -ex \
    && apk add --no-cache \
        git \
        build-base \
        autoconf \
        automake \
        libtool \
        linux-headers \
        c-ares-dev \
        libev-dev \
        libsodium-dev \
        mbedtls-dev \
        pcre-dev \
    && cd /tmp \
    && git clone --depth=1 --recursive "https://github.com/shadowsocks/shadowsocks-libev" \
    && cd shadowsocks-libev \
    && ./autogen.sh \
    && ./configure --prefix=/usr --disable-documentation \
    && make -j $(nproc) \
    && strip src/ss-local \
    && strip src/ss-manager \
    && strip src/ss-redir \
    && strip src/ss-server \
    && strip src/ss-tunnel

FROM alpine:latest

RUN set -xe \
    && apk add --no-cache \
        ca-certificates \
        c-ares \
        libev \
        libsodium \
        mbedtls \
        pcre

COPY --from=builder /tmp/shadowsocks-libev/src/ss-local     /usr/bin/ss-local
COPY --from=builder /tmp/shadowsocks-libev/src/ss-manager   /usr/bin/ss-manager
COPY --from=builder /tmp/shadowsocks-libev/src/ss-nat       /usr/bin/ss-nat
COPY --from=builder /tmp/shadowsocks-libev/src/ss-redir     /usr/bin/ss-redir
COPY --from=builder /tmp/shadowsocks-libev/src/ss-server    /usr/bin/ss-server
COPY --from=builder /tmp/shadowsocks-libev/src/ss-tunnel    /usr/bin/ss-tunnel

CMD ["/bin/sh"]
