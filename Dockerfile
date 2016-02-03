# Docker-Shiny

FROM ubuntu:15.10
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'

ENV RSTUDIO_REPOSITORY 'deb http://cran.rstudio.com/bin/linux/ubuntu wily/'
ENV UBUNTUGIS_REPOSITORY 'ppa:ubuntugis/ubuntugis-unstable'
ENV R_REPOS "'http://cran.rstudio.com/'"

# Need these for apt-add-repository command
ENV APT_PACKAGES 'software-properties-common python-software-properties'

ENV PACKAGES 'r-base gdal-bin libgdal1-dev libproj-dev'

# Edit R packages to suit your needs
ENV R_PACKAGES "'lubridate','ggplot2','shiny','rgdal','sp','raster','rasterVis','reshape2','shape','maptools','fields','magicaxis','leaflet','rgdal','sp','raster'"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $APT_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN echo "${RSTUDIO_REPOSITORY}" > /etc/apt/sources.list.d/rstudio.list
RUN add-apt-repository -y -u "${UBUNTUGIS_REPOSITORY}"

RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add - 

RUN apt-get update && \
    apt-get install -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c(${R_PACKAGES}),repos=${R_REPOS})"

EXPOSE 3838
ENTRYPOINT ['R']
CMD ['--help']
