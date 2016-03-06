FROM ubuntu:14.04

MAINTAINER Thomas Nowotny <thomas.nowotny@criteriamx.com>

ENV FACTORIO_VERSION 0.12.26
ENV FACTORIO_SAVE_NAME mysave
ENV FACTORIO_AUTOSAVE_INTERVAL 10
ENV FACTORIO_AUTOSAVE_SLOTS 3

RUN apt-get update && \
    apt-get install -y curl --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

RUN curl -L -k https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 | tar -xzf -

ADD ./init.sh /opt/factorio/bin

VOLUME opt/factorio/config
VOLUME opt/factorio/saves
VOLUME opt/factorio/mods

EXPOSE 34197/udp

WORKDIR /opt/factorio/bin

CMD ["bash", "-c", "./init.sh"]
