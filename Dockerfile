# Docker-Shiny
FROM ubuntu:vivid
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'

ENV UBUNTU_VERSION 'vivid'

ENV UBUNTU_UNIVERSE_REPO "deb http://archive.ubuntu.com/ubuntu ${UBUNTU_VERSION} universe"
ENV RSTUDIO_REPO "deb http://cran.rstudio.com/bin/linux/ubuntu ${UBUNTU_VERSION}/"
ENV UBUNTUGIS_REPO 'ppa:ubuntugis/ubuntugis-unstable'
ENV R_REPOS "'http://cran.rstudio.com/'"
ENV SHINY_SERVER "https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.1.759-amd64.deb"

# Need these for apt-add-repository command
ENV APT_PACKAGES 'software-properties-common python-software-properties'

ENV PACKAGES 'r-base gdal-bin libgdal1-dev libproj-dev gdebi-core'

# Edit R packages to suit your needs
ENV R_PACKAGES "'lubridate','ggplot2','shiny','rgdal','sp','raster','rasterVis','reshape2','shape','maptools','fields','magicaxis','leaflet','rgdal','sp','raster'"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $APT_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

# Something breaks with the key using add-apt-repository
# Need to investigate why
RUN echo "${RSTUDIO_REPO}" > /etc/apt/sources.list.d/rstudio.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add - 

RUN add-apt-repository -y "${UBUNTU_UNIVERSE_REPO}"
RUN add-apt-repository -y "${UBUNTUGIS_REPO}"

RUN apt-get update && \
    apt-get install -y $PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c(${R_PACKAGES}),repos=${R_REPOS})"

RUN curl $SHINY_SERVER -o /tmp/shiny-server.deb && \
    gdebi /tmp/shiny-server.deb && \
    rm /tmp/shiny-server.deb

EXPOSE 3838
ENTRYPOINT [ 'R' ]
CMD [ '--help' ]
