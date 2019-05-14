#!/usr/bin/env sh

if [[ $RUN_MODE == "local" ]]
then
    sleep 3
    curl -s --socks5 127.0.0.1:$(cat /etc/shadowsocks-libev/config.json | jq -r .local_port) "http://ip.aliyun.com/service/getIpInfo.php?ip=myip" | jq .
fi
