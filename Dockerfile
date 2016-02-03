# Docker-Shiny

FROM ubuntu:15.10
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'
ENV MIN_APT_GET 'apt-get install -y --no-install-recommends'

ENV RSTUDIO_REPOSITORY 'deb http://cran.rstudio.com/bin/linux/ubuntu wily/'
ENV PACKAGES ''

RUN echo $RSTUDIO_REPOSITORY > /etc/apt/sources.list.d/rstudio.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add -

RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

