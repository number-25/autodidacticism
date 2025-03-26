# syntax=docker/dockerfile:1
# alphine-plus-plus-plus built upon alpine-plus-plus. Extended to include datamash (and grep?)

## PREAMBLE

## == BASE IMAGE == ##
FROM cicirello/alpine-plus-plus:latest

## == ENV VARIABLES == ##

## == LABELS == ##
LABEL dockerfile.maintainer="Dean Bašić"
LABEL software.home="https://github.com/cicirello/alpine-plus-plus"
LABEL base.image="alpine-plus-plus:3.21.0"
LABEL base.version="3.21.0"

## == INTALLS == ##

RUN apk update && \
    apk add --no-cache \
    datamash \
    grep \
    gzip \
    util-linux

