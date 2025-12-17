# syntax=docker/dockerfile:1
# bambu version 3.12

## PREAMBLE

## == BASE IMAGE == ##
FROM bioconductor/bioconductor_docker:latest

## Change shell to expose /bin/bash
#SHELL ["/bin/bash", "--login" ,"-c"]

## == ENV VARIABLES == ##
ENV BAMBU_VERSION="3.12.0"
ENV R_VERSION="4.5.2"
ENV BIOCONDUCTOR_VERSION="3.22"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="bambu"
LABEL software.home="https://bioconductor.org/packages/release/bioc/html/bambu.html"
LABEL software.version="3.12.0"
LABEL publication.doi="https://doi.org/doi:10.18129/B9.bioc.bambu"
LABEL base.image="bioconductor_docker"

## BODY 

## Change USER
USER root

#WORKDIR /app/

## BASIC SYSTEM UPDATE
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

## INSTALL R PACKAGES

RUN R -e 'BiocManager::install("bambu")'

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .
#RUN addgroup -S user && adduser -S user -G user

#USER user
# END 

