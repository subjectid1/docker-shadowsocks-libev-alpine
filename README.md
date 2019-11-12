# shadowsocks-libev-alpine

## server model

```yaml
version: '2'
services:
    shadowsocks-server:
        image: xiaozhuai/shadowsocks-libev-alpine:latest
        ports:
            - 8888:8888
        command: ss-server -s 0.0.0.0 -p 8888 -k shadowsocks-libev-alpine -m chacha20-ietf-poly1305
```

## local mode

```yaml
version: '2'
services:
    shadowsocks-client:
        image: xiaozhuai/shadowsocks-libev-alpine:latest
        ports:
            - 6767:6767
        command: ss-local -s x.x.x.x -p 8888 -b 0.0.0.0 -l 6767 -k shadowsocks-libev-alpine -m chacha20-ietf-poly1305
```
