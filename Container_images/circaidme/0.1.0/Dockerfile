# syntax=docker/dockerfile:1

FROM ubuntu:22.04

# Image metadata
LABEL maintainer="deancompbio@pm.me"

# Define version as build variable
ARG CIRC_VER="0.1.0"

# Good practice variables
ENV DEBIAN_FRONTEND="noninteractive"
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"

#COPY . /app

RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get install -y git && \
    apt-get install -y python3-pip \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Build CircAidMe from github address 

RUN pip3 install pandas && \
    pip3 install regex && \
    pip3 install biopython && \
    pip3 install git+https://github.com/ms-gx/CircAidMe.git

#CMD python /app/app.py

# Define PATH variable
ENV PATH=/apps/bin:$PATH

# Default shell to be bash
CMD ["/bin/bash"] 
