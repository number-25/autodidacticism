# syntax=docker/dockerfile:1
# transigner - transcript quantification from long read sequencing data 

## PREAMBLE

## == BASE IMAGE == ##
FROM debian:11-slim 

## == ENV VARIABLES == ##
ENV TRANSIGNER_VERSION="1.2.0"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="transigner"
LABEL software.developers="Hyun Joo Ji, Mihaela Pertea"
LABEL software.home="https://github.com/haydenji0731/transigner"
LABEL software.version="1.2.0"
LABEL publication.doi="https://doi.org/10.1101/2024.04.13.589356"
LABEL base.image="debian11-slim"

## BODY 

## Change USER
USER root

### Create directory for application
RUN mkdir /apps 
WORKDIR /apps 

### Apk installs with --no-cache option to save space 
RUN apt update && \
    apt install git \
    ca-certificates \
    build-essential \
    automake \
    autoconf \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    wget \
    -yq --no-install-suggests --no-install-recommends --allow-downgrades --allow-remove-essential --allow-change-held-packages && \
    apt-get clean

### Download transigner source 
RUN git clone --recurse-submodules https://github.com/haydenji0731/transigner && \
    cd transigner && \
    make release 
    
WORKDIR /apps/transigner

# Add transigner directory to PATH
ENV PATH="${PATH}:/apps/transigner"

## == CLEAN UP == ##

RUN apt-get purge -yq \
    ca-certificates \
    build-essential \
    automake \
    autoconf \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev

CMD ["transigner"]

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .
#RUN addgroup -S user && adduser -S user -G user

#USER user
# END 
