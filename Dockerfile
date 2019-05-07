FROM alpine:latest

# Install the magic wrapper.
ADD ./start.sh /start.sh
ADD ./config.ini /config.ini

RUN mkdir /data && \
    apk add --no-cache dnsmasq cpulimit docker dynamips gns3-server qemu-img qemu-system-x86_64 ubridge vpcs iouyap wget && \
    pip3 install idna jsonschema==2.6.0 && \
    wget -O /usr/bin/vpcs https://sourceforge.net/projects/vpcs/files/latest/download

CMD [ "/start.sh" ]

WORKDIR /data

VOLUME ["/data"]

