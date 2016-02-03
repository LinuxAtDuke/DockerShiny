# Docker-Shiny

FROM ubuntu:15.10
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'

ENV RSTUDIO_REPOSITORY 'deb http://cran.rstudio.com/bin/linux/ubuntu wily/'
ENV PACKAGES 'r-base'
ENV R_PACKAGES "'lubridate','ggplot2','shiny','rgdal','sp','raster','rasterVis','reshape2','shape','maptools','fields','magicaxis','leaflet'"
ENV R_REPOS "'http://cran.rstudio.com/'"


RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

RUN echo $RSTUDIO_REPOSITORY > /etc/apt/sources.list.d/rstudio.list && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add - && \
    apt-get update && \
    apt-get install -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*


RUN R -e "install.packages(c(${R_PACKAGES}),repos=${R_REPOS})"

EXPOSE 3838
ENTRYPOINT ['R']
CMD ['--help']
