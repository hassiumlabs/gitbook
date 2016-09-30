FROM node:slim
MAINTAINER Andy@AndySpohn.com

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
    	unzip calibre xsltproc curl calibre fonts-noto && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove && \    
    rm -rf /var/lib/apt/lists/*

RUN npm install -g gitbook-cli ebook-convert && \
    gitbook fetch && \
    rm -rf /root/.npm /tmp/npm*

WORKDIR /srv/gitbook

VOLUME /srv/gitbook

EXPOSE 4000

CMD gitbook --version
