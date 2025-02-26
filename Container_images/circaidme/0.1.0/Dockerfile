# syntax=docker/dockerfile:1
# cirdaidme software using python 3.9 alpine

## PREAMBLE

## == BASE IMAGE == ##
FROM python:3.9.21-alpine3.21

## == ENV VARIABLES == ##
ENV PYTHON_VERSION="3.9.21"
ENV CIRDAIDME_VERSION="0.1.0"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL docker.repo="https://hub.docker.com/repository/docker/number25/circaidme/general"
LABEL maintainer.email="deancompbio@pm.me"
LABEL software.name="circaidme"
#LABEL software.developers=""
LABEL software.home="https://github.com/ms-gx/CircAidMe"
LABEL software.version="0.1.0"
#LABEL publication.doi=""
LABEL base.image="python3.9.21-alpine3.21"

# Good practice variables 
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"

# Change to root user 
USER root  

# cd into dockers /app directory designated for software
WORKDIR /app

## BODY 

RUN apk add --no-cache \
    git \
    gcc \
    make \
    musl-dev 

# Build CircAidMe from github address 
RUN pip install --no-cache-dir pandas && \
    pip install --no-cache-dir regex && \
    pip install --no-cache-dir biopython && \
    pip install --no-cache-dir git+https://github.com/ms-gx/CircAidMe.git && \
    rm -rf /tmp/* /var/tmp/* && \
    chmod -R a+rX /app 

RUN apk del \
    #git \
    #gcc 
    #make \
    musl-dev 

# Define PATH variable
ENV PATH=/app/:$PATH

# Default shell to be bash
#CMD ["/bin/bash"] 
