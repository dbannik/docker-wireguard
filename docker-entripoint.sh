#!/bin/bash

CONFIG_DIR='/etc/wireguard'
PRIVATE_KEY_FILE="$CONFIG_DIR/privatekey"
PUBLIC_KEY_FILE="$CONFIG_DIR/publickey"
WG_ADDRESS=${WG_ADDRESS:-10.0.0.1/24}

if [[ ! "$(ls "$CONFIG_DIR")" ]]; then
    # Automatic configure
    PRIVATE_KEY=${PRIVATE_KEY:-$(wg genkey)}
    echo "$PRIVATE_KEY" > "$PRIVATE_KEY_FILE"

    PUBLIC_KEY=${PUBLIC_KEY:-$(wg pubkey < "$PRIVATE_KEY_FILE")}
    echo "$PUBLIC_KEY" > "$PUBLIC_KEY_FILE"

    cat <<EOF | tee "$CONFIG_DIR/wg0.conf"
[Interface]
Address = ${WG_ADDRESS}
PrivateKey = ${PRIVATE_KEY}
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

EOF

fi

wg-quick up wg0

exec "$@"
