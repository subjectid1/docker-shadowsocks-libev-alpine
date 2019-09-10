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

```json
{
    "server": "x.x.x.x",
    "server_port": 9999,
    "local_address": "0.0.0.0",
    "local_port": 1080,
    "password": "xxxxxx",
    "timeout": 60,
    "method": "chacha20-ietf-poly1305"
}
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

```json
{
    "server": "0.0.0.0",
    "server_port": 9999,
    "password": "xxxxxx",
    "timeout": 60,
    "method": "chacha20-ietf-poly1305"
}
```