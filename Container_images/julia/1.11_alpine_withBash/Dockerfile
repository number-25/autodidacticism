# syntax=docker/dockerfile:1
# Julia base with packages Glob and FileIO included

## PREAMBLE

## == BASE IMAGE == ##
FROM julia:1.10.8-alpine3.21

## == ENV VARIABLES == ##
ENV JULIA_VERSION="1.10.8"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL docker.repo="https://hub.docker.com/_/julia"
LABEL maintainer.email="deancompbio@pm.me"
LABEL software.name="julia"
#LABEL software.developers=""
LABEL software.home="https://julialang.org/"
LABEL software.version="1.10.8"
#LABEL publication.doi=""
LABEL base.image="alpine_linux"

# Define version as build variable
ARG JULIA_VER="1.10.8"

## == BODY MEAT AND BONES == ## 

## Change USER
USER root

# Begin install
RUN apk update && \
    apk add --no-cache \ 
    procps \
    bash \
    coreutils

# Set Julia Depot path as recommended by nextflow
ENV JULIA_DEPOT_PATH=/usr/local/share/julia
ENV PATH=$PATH:$JULIA_DEPOT_PATH

RUN julia -e 'import Pkg; Pkg.update(); Pkg.add(["Glob", "FileIO"]); Pkg.precompile(); using Glob, FileIO;'

## Clean up tmps, filesystem
RUN rm -rf /tmp/* /var/tmp/*

## == FINALISING INSTALL == ##

#CMD ["/bin/sh"]
CMD ["julia"]  

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .

# ... and efectively using that user
#USER user
