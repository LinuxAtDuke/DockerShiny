# Docker-Shiny
FROM ubuntu:15.10
MAINTAINER Chris Collins <christopher.collins@duke.edu> & Matthew Ross <matthewross07@gmail.com>

ENV CONTAINER 'docker'
ENV TERM 'xterm'
ENV DEBIAN_FRONTEND 'noninteractive'

ENV UBUNTU_VERSION 'wily'

ENV UBUNTU_UNIVERSE_REPO "deb http://archive.ubuntu.com/ubuntu ${UBUNTU_VERSION} universe"
ENV UBUNTU_BACKPORTS_REPO "deb http://archive.ubuntu.com/ubuntu ${UBUNTU_VERSION}-backports main restricted universe"
ENV RSTUDIO_REPO "deb http://cran.rstudio.com/bin/linux/ubuntu ${UBUNTU_VERSION}/"

# Need APT_PACKAGES for apt-add-repository command
ENV APT_PACKAGES 'software-properties-common python-software-properties'
ENV R_BASE_PACKAGES 'r-base r-base-dev'

# R Internal repos/packages
ENV R_REPOS "'http://cran.rstudio.com/'"
ENV R_PACKAGES "'lubridate','ggplot2','shiny','rgdal','sp','raster','rasterVis','reshape2','shape','maptools','fields','magicaxis','leaflet','rgdal','sp','raster'"
ENV GDEBI_PACKAGES 'gdebi-core'
ENV GDAL_PACKAGES 'gdal-bin libgdal1-dev libproj-dev'

ENV SHINY_SERVER "https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.1.759-amd64.deb"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $APT_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y "${UBUNTU_BACKPORTS_REPO}"

# Something breaks with the key using add-apt-repository
# Need to investigate why
RUN echo "${RSTUDIO_REPO}" > /etc/apt/sources.list.d/rstudio.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update && \
    apt-get install -y $R_BASE_PACKAGES $GDAL_PACKAGES $GDEBI_PACKAGES && \
    rm -rf /var/lib/apt/lists/*

# Install the extra R packages, and shiny
RUN R -e "install.packages(c(${R_PACKAGES}),repos=${R_REPOS})"

# Install shiny-server
RUN curl $SHINY_SERVER -o /tmp/shiny-server.deb 

# Following fixes a bug with the libssl version in the shiny server package on later ubuntu versions
# 0.9.8 not available, and insecure, but it can use 1.0.0 instead
RUN mkdir -p /tmp/repackage && \
    dpkg-deb -R /tmp/shiny-server.deb /tmp/repackage && \
    sed -i 's/libssl0.9.8/libssl1.0.0/' /tmp/repackage/DEBIAN/control && \
    dpkg-deb -b /tmp/repackage /tmp/shiny-server.deb

RUN gdebi -n /tmp/shiny-server.deb && \
    rm /tmp/shiny-server.deb

EXPOSE 3838
ENTRYPOINT [ 'R' ]
CMD [ '--help' ]

