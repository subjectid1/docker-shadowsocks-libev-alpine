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
    && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var \
        --disable-documentation \
    && make -j $(nproc) \
    && strip src/ss-local \
    && strip src/ss-manager \
    && strip src/ss-redir \
    && strip src/ss-server \
    && strip src/ss-tunnel

FROM alpine:latest

RUN set -xe \
    && apk add --no-cache \
        c-ares \
        libev \
        libsodium \
        mbedtls \
        pcre

# ss-nat is only for OpenWRT, ignore it
COPY --from=builder \
    /tmp/shadowsocks-libev/src/ss-local \
    /tmp/shadowsocks-libev/src/ss-manager \
    /tmp/shadowsocks-libev/src/ss-redir \
    /tmp/shadowsocks-libev/src/ss-server \
    /tmp/shadowsocks-libev/src/ss-tunnel \
    /usr/bin/
EXPOSE 8888
CMD ["/bin/sh"]
