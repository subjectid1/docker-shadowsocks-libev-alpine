# shadowsocks-libev-alpine

## local mode

```yaml
version: '2'
services:
    shadowsocks-client:
        image: xiaozhuai/shadowsocks-libev-alpine:latest
        volumes:
            - ./config-local.json:/etc/shadowsocks-libev/config.json
        ports:
          - 1080:1080
        environment:
            RUN_MODE: local
```

## server model

```yaml
version: '2'
services:
    shadowsocks-server:
        image: xiaozhuai/shadowsocks-libev-alpine:latest
        volumes:
            - ./config-server.json:/etc/shadowsocks-libev/config.json
        ports:
          - 9999:9999
        environment:
            RUN_MODE: server
```
