FROM ubuntu:20.04

RUN apt update \
    && apt install -y iptables iproute2 net-tools nano wireguard

COPY docker-entripoint.sh /docker-entripoint.sh

VOLUME /etc/wireguard/
EXPOSE 51820/udp

ENTRYPOINT ["bash", "/docker-entripoint.sh"]

HEALTHCHECK --interval=3s --timeout=1s --retries=3 \
  CMD ifconfig wg0 || exit 1
