FROM alpine
MAINTAINER Vladimir Hodakov <vladimir@hodakov.me>

RUN apk add --no-cache tini bash samba-common-tools samba-server

COPY entrypoint.sh /usr/local/bin/entrypoint

RUN ["chmod", "+x", "/usr/local/bin/entrypoint"]

VOLUME /etc/samba \
       /var/lib/samba \
       /data

EXPOSE 137/udp \
       138/udp \
       139/tcp \
       445/tcp

CMD ["/sbin/tini", "--", "/usr/local/bin/entrypoint"]
