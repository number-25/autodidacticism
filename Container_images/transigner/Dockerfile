# syntax=docker/dockerfile:1
# transigner - transcript quantification from long read sequencing data 

## PREAMBLE

## == BASE IMAGE == ##
FROM ericmiguel/alpine-conda:0.0.1

## == ENV VARIABLES == ##
ENV TRANSIGNER_VERSION="1.1.3"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="transigner"
LABEL software.developers="Hyun Joo Ji, Mihaela Pertea"
LABEL software.home="https://github.com/haydenji0731/transigner"
LABEL software.version="1.1.3"
LABEL publication.doi="https://doi.org/10.1101/2024.04.13.589356"
LABEL base.image="miniconda3"
LABEL python.version="3.12"

## MEAT AND BONES 

## Change USER
USER root

### Download transigner source 

RUN mkdir /meat 
WORKDIR /meat 

RUN wget -q https://github.com/haydenji0731/transigner/archive/refs/tags/v${TRANSIGNER_VERSION}.tar.gz -O /meat/transigner-${TRANSIGNER_VERSION}.tar.gz && \
    tar -zxvf /meat/transigner-${TRANSIGNER_VERSION}.tar.gz && \
    rm /meat/transigner-${TRANSIGNER_VERSION}.tar.gz 

WORKDIR /meat/transigner-1.1.3

### Apk installs

RUN apk add --no-cache \
    make \
    clang \
    musl-dev \
    gcc 

### Create conda environment 

RUN conda \
    create -n transigner \
    bioconda::minimap2 \
    samtools \
    pip \
    bioconda::pysam \
    numpy \
    #conda-forge::clang \
    pandas && \
    /bin/sh -c activate transigner && \
    make CFLAGS="-fopenmp" && \
    pip install --no-cache-dir . && \
    conda clean -a && \
    chmod -R a+rX /meat

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .

# ... and efectively using that user
#USER user
