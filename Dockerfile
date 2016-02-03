# Docker-Shiny

FROM ubuntu:15.10
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'
ENV MIN_APT_GET 'apt-get install -y --no-install-recommends'
ENV PACKAGES ''

RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*
