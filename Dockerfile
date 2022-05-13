## Create image with
# docker build -t <image_name> -f Dockerfile .
# docker run --rm -it --entrypoint /bin/bash <image_name>
## Run image
## By combining the two :
# docker build -t <image_name> -f Dockerfile . && docker run --rm -it --entrypoint /bin/bash <image_name>

FROM ubuntu:20.04

RUN apt-get update && \
apt-get install -y wget vim nano git curl

# To avoid the issue when timezone is asked
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich

# Basic objects
RUN apt-get install -y build-essential gfortran openmpi-bin libopenmpi-dev \ 
    python3 python3-pip python3-dev git python3-tk

RUN pip install future requests matplotlib==3.2 numpy scipy mpi4py h5py

# Linking python3 to python command
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apt-get install -y libeigen3-dev libboost-all-dev \
    python3-petsc4py-complex python3-slepc4py-complex

# Download and install EMopt
WORKDIR /root/
RUN git clone https://github.com/Dj1312/emopt
WORKDIR /root/emopt/
RUN python setup.py install
WORKDIR /root/

SHELL ["/bin/sh", "-c"]
