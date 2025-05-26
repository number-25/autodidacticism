# syntax=docker/dockerfile:1
# sylph-tax: incorporating taxonomy into sylph  

## PREAMBLE

## == BASE IMAGE == ##
FROM mambaorg/micromamba:alpine3.20

## Change shell to expose /bin/bash
#SHELL ["/bin/bash", "--login" ,"-c"]

## == ENV VARIABLES == ##
ENV SYLPH_TAX_VERSION="1.2.0"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="sylph-tax"
LABEL software.developers="Jim Shaw"
LABEL software.home="https://github.com/bluenote-1577/sylph-tax"
LABEL software.version="1.2.0"
LABEL software.documentation="https://sylph-docs.github.io/sylph-tax/"
#LABEL publication.doi=""
LABEL base.image="micromamba:alpine3.20"
LABEL python.version="3.9"

## BODY 

## Change USER
#USER root

#RUN mkdir /apps 
#WORKDIR /apps 

### Create micromamba(conda) environment and install a single package into it

RUN micromamba \
    create -n sylph_tax bioconda::sylph-tax  

### Clean up conda install 
RUN micromamba clean --all --yes

# Activate the environment

ARG MAMBA_DOCKERFILE_ACTIVATE=1 

# Add mamba packages to path 

ENV PATH="${PATH}:/opt/conda/envs/sylph_tax/bin/"

#= Expose command =#
CMD ["sylph-tax"]

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .
#RUN addgroup -S user && adduser -S user -G user

#USER user
# END 
