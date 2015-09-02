FROM nowk/alpine-c:4.9.2
MAINTAINER Yung Hwa Kwon <yung.kwon@damncarousel.com>

# install dependencies for the cs50 tools check50 and style50
RUN apk --update add \
	git \
	nodejs \
	openjdk7-jre-base \
	&& rm -rf /var/cache/apk/*

# install 50s
COPY install-50s /opt/
RUN /opt/install-50s && rm /opt/install-50s

# create a user so we are not root
RUN adduser -D -u 1001 -g '' cs50 \
	&& mkdir -p /src \
	&& chown -R cs50:cs50 /src

COPY docker-entrypoint /
ENTRYPOINT [ "/docker-entrypoint" ]

USER cs50
WORKDIR /src

# /src is the source code volume mountpoint
VOLUME /src

