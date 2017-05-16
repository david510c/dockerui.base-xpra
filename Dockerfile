FROM ubuntu:16.04

COPY keys/ /tmp/keys/

RUN apt-key add /tmp/keys/xpra.org-20180504.asc && \
    echo "deb http://xpra.org/ xenial main" > /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -q -y gosu dbus-x11 libgtk2.0-0 libcanberra-gtk-module xpra=2.0-r15319-1 x11-apps xterm remmina

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN mkdir -m 770 /var/run/xpra && \
    chgrp xpra /var/run/xpra

ENV GUEST_USER=user \
    GUEST_UID=9001 \
    GUEST_GROUP=user \
    GUEST_GID=9001 \
    DISPLAY=:0 \
    XPRA_OPTIONS=

EXPOSE 8000

ADD common/ debian-series/ /docker/
RUN chmod a+x /docker/*
ENTRYPOINT ["/docker/entrypoint.sh"]
