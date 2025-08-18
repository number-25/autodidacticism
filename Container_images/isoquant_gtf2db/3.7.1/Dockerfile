# syntax=docker/dockerfile:1
# gtf2bed.py from IsoQuant - convert gff/gtf annotation to db file for us in IsoQuant 

## PREAMBLE

## == BASE IMAGE == ##
FROM alpine:3.22.1

## Change shell to expose /bin/bash
#SHELL ["/bin/bash", "--login" ,"-c"]

## == ENV VARIABLES == ##
ENV ISOQUANT_VERSION="3.7.1"

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.name="IsoQuant"
LABEL software.home="https://github.com/ablab/IsoQuant/tree/master/src/"
LABEL software.version="3.7.1"
LABEL publication.doi="https://doi.org/10.1038/s41587-022-01565-y"
LABEL base.image="alpine3.22.1"

## BODY 

## Change USER
USER root

WORKDIR /app/

### Apk installs with --no-cache option to save space 
RUN apk update && \
    apk add --no-cache \
    python3 \
    wget

### Create python virtual env 
RUN python3 -m venv /opt/venv 

### Enable venv
ENV PATH="/opt/venv/bin:$PATH"
### Create directory for application
RUN mkdir -p /opt/venv/data

### Instal pip dependencies 
RUN pip install gffutils>=0.10.1 

### Download gtf2db.py script 
RUN wget --progress=dot:giga https://raw.githubusercontent.com/ablab/IsoQuant/refs/heads/master/src/gtf2db.py && \
    chmod +x gtf2db.py 

# Add script to path
ENV PATH="${PATH}:/app"

## == CLEAN UP == ##
RUN apk del wget 

WORKDIR /opt/venv/data

CMD ["python3", "gtf2db.py"]

# Creating an user for non root executions inside the container...
#RUN groupadd user && useradd -r -g user user && chown user:user .
#RUN addgroup -S user && adduser -S user -G user

#USER user
# END 
