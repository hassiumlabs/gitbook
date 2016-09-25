FROM alpine:latest

MAINTAINER Andy@AndySpohn.com

ARG VERSION=3.2.0

LABEL version=$version

RUN apk add --no-cache bash nodejs git && \
    npm install -g gitbook-cli &&         \
    npm install -g gitbook-convert &&     \
	gitbook fetch ${VERSION} &&           \
	npm cache clear &&                    \
	rm -rf /tmp/* &&                      \
	mkdir -p /srv

WORKDIR /srv/gitbook

VOLUME /srv/gitbook

EXPOSE 4000

CMD gitbook serve
