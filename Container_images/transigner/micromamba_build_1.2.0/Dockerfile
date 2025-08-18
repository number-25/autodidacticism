# syntax=docker/dockerfile:1
# transigner - transcript quantification from long read sequencing data 

## PREAMBLE

## == BASE IMAGE == ##
FROM alpine:3.22.1

## Change shell to expose /bin/bash
#SHELL ["/bin/bash", "--login" ,"-c"]

## == ENV VARIABLES == ##
ENV TRANSIGNER_VERSION="1.2.0"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="transigner"
LABEL software.developers="Hyun Joo Ji, Mihaela Pertea"
LABEL software.home="https://github.com/haydenji0731/transigner"
LABEL software.version="1.2.0"
LABEL publication.doi="https://doi.org/10.1101/2024.04.13.589356"
LABEL base.image="alpine3.22.1"

## BODY 

## Change USER
USER root

### Create directory for application
RUN mkdir /apps 
WORKDIR /apps 

### Apk installs with --no-cache option to save space 
### Packages for compiling transigner, and bash to allow easy.sh to run

RUN apk add --no-cache \
    make \
    openmp-dev \
    musl-dev \
    gcc \
    automake \
    autoconf \
    pkgconf \
    gsl-dev \
    libbz2 \
    bzip2-dev \
    xz-libs \
    xz \
    zlib-dev \
    xz-dev \
    libcrypto3 \
    libdeflate-dev \
    libcurl \
    curl-dev \
    #htslib \
    #htslib-dev \
    git \
    g++ \
    bash \
    libgomp 

### Download transigner source 
RUN git clone --recurse-submodules https://github.com/haydenji0731/transigner && \
    cd transigner && \
    make release

#RUN wget -q https://github.com/haydenji0731/transigner/archive/refs/tags/v${TRANSIGNER_VERSION}.zip -O /apps/transigner-${TRANSIGNER_VERSION}.zip && \
#    unzip /apps/transigner-${TRANSIGNER_VERSION}.zip && \
#    rm /apps/transigner-${TRANSIGNER_VERSION}.zip 

WORKDIR /apps/transigner

# Add transigner directory to PATH, this will allow the use of eash.sh script
ENV PATH="${PATH}:/apps/transigner"

#RUN micromamba install --yes \ 
#    bioconda::samtools \
#    conda-forge::pip \
#    bioconda::pysam \
#    conda-forge::numpy \
#    conda-forge::pandas && \
#    make CFLAGS="-fopenmp" && \
#    pip install --no-cache-dir . && \
#    micromamba clean --all --yes && \
#    chmod -R a+rX /apps 

# Add mamba packages to path 

#ENV PATH="${PATH}:/opt/conda/envs/transigner/bin/"

## == CLEAN UP == ##

RUN apk del \
    make \
    musl-dev \
    gcc 

CMD ["transigner"]

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .
#RUN addgroup -S user && adduser -S user -G user

#USER user
# END 
