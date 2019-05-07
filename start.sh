#!/bin/sh
if [ "${CONFIG}x" == "x" ]; then
	CONFIG=/data/config.ini
fi

if [ ! -e $CONFIG ]; then
	cp /config.ini /data
fi

brctl addbr virbr0
ip link set dev virbr0 up
if [ "${BRIDGE_ADDRESS}x" == "x" ]; then
  BRIDGE_ADDRESS=192.168.251.1/24
fi
ip ad add ${BRIDGE_ADDRESS} dev virbr0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

dnsmasq -i virbr0 -z -h --dhcp-range=192.168.251.10,192.168.251.250,1h
dockerd --storage-driver=vfs --data-root=/data/docker/ &
gns3server -A --config /data/config.ini
