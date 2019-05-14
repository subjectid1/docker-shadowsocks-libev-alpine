#!/usr/bin/env sh

echo Running as $RUN_MODE mode
checkip.sh &
ss-$RUN_MODE -c /etc/shadowsocks-libev/config.json
