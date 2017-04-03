FROM alpine:edge
MAINTAINER Charlie Wang <272876047@qq.com>

Run apk upgrade -q -U -a && apk add -q -U php7 php7-gd && php7 -r 
RUN apk add --update openssh util-linux dbus curl ttf-freefont xauth xf86-input-keyboard sudo\
    && rm  -rf /tmp/* /var/cache/apk/*
RUN addgroup alpine \
&& adduser  -G alpine -s /bin/sh -D alpine \
&& echo "alpine:alpine" | /usr/sbin/chpasswd \
&& echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers

ADD entrypoint.sh /usr/sbin
RUN chmod +x /usr/sbin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
