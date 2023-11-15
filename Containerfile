FROM quay.io/centos-boot/fedora-tier-1:eln
RUN curl -Lo /tmp/caddy.tar.gz https://github.com/caddyserver/caddy/releases/download/v2.7.5/caddy_2.7.5_linux_amd64.tar.gz && \
    tar xvf /tmp/caddy.tar.gz && \
    mv caddy /usr/bin/ && \
    mkdir /usr/share/www

ADD caddy.service /usr/lib/systemd/system/caddy.service

RUN systemctl enable caddy

ADD index.html /usr/share/www/


