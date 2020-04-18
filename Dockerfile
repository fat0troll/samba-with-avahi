FROM alpine
MAINTAINER Vladimir Hodakov <vladimir@hodakov.me>

RUN apk add --no-cache samba-common-tools samba-server

VOLUME /etc/samba \
       /var/lib/samba \
       /data

EXPOSE 137/udp \
       138/udp \
       139/tcp \
       445/tcp

CMD nmbd -D && smbd -FS --no-process-group
