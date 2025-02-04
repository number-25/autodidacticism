# syntax=docker/dockerfile:1
# transigner - transcript quantification from long read sequencing data 

## PREAMBLE

## == BASE IMAGE == ##
FROM continuumio/miniconda3

## == ENV VARIABLES == ##
ENV TRANSIGNER_VERSION="1.1.3"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="transigner"
LABEL software.developers="Hyun Joo Ji, Mihaela Pertea"
LABEL software.home="https://github.com/haydenji0731/transigner"
LABEL software.version="1.1.3"
LABEL publication_doi="https://doi.org/10.1101/2024.04.13.589356"
LABEL base_image="miniconda3"
LABEL python_version="3.12"

## MEAT AND BONES 

### Download transigner source 

RUN mkdir /meat && mkdir /meat/transigner 
WORKDIR /meat 

RUN wget https://github.com/haydenji0731/transigner/archive/refs/tags/v${TRANSIGNER_VERSION}.tar.gz -O /meat/transigner-${TRANSIGNER_VERSION}.tar.gz && \
    tar -zxvf /meat/transigner-${TRANSIGNER_VERSION}.tar.gz -C /meat/transigner && \
    rm /meat/transigner-${TRANSIGNER_VERSION}.tar.gz && \
    cd /meat/transigner

### Create conda environment 

RUN conda \
    create -n transigner \
    pip \
    bioconda::pysam \
    numpy \
    conda-forge::libclang \
    pandas && \
    /bin/sh -c activate transigner && \
    make CFLAGS="-fopenmp" && \
    pip install . && \
    conda clean -a && \
    chmod -R a+rX /meat


        





