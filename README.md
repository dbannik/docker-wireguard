# docker-wireguard

### run
    docker run -d --cap-add=NET_ADMIN -p 51820:51820/udp sovich/wireguard tail -f /dev/null
    
if use custom config

    docker run -d \
    --cap-add=NET_ADMIN \
    -p 51820:51820/udp \
    -v $(pwd)/wg0.conf:/etc/wireguard/wg0.conf \
    sovich/wireguard tail -f /dev/null
    
automatic create configuration example

    docker run -d \
    --cap-add=NET_ADMIN \
    -p 51820:51820/udp \
    -e WG_ADDRESS=192.168.2.1/24 \
    -e PRIVATE_KEY=OJG2h44gQjMXZBcfECLfsojwjVs/41kj1Lzhpe5hnlI= \
    -e PUBLIC_KEY=OJG2h44gQjMXZBcfECLfsojwjVs/41kj1Lzhpe5hnlI= \
    -v $(pwd):/etc/wireguard/ \
    sovich/wireguard tail -f /dev/null