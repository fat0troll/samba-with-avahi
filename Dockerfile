FROM alpine
MAINTAINER Vladimir Hodakov <vladimir@hodakov.me>

RUN apk add --no-cache tini bash samba-common-tools samba-server avahi avahi-tools

COPY entrypoint.sh /usr/local/bin/entrypoint

RUN ["chmod", "+x", "/usr/local/bin/entrypoint"]

VOLUME /etc/avahi \
       /etc/samba \
       /var/lib/samba \
       /data

CMD ["/sbin/tini", "--", "/usr/local/bin/entrypoint"]
