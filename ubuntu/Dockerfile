FROM ubuntu:18.04

USER root

# update ubuntu repo for China
#RUN rm /etc/apt/sources.list
#ADD ./sources.list.xenial /etc/apt/sources.list
#RUN apt-get clean && \
  #apt-get update --fix-missing

# install ubuntu packages
RUN apt-get update \
    && apt-get install -y build-essential \
    libkrb5-dev \
    curl \
    python \
    git \
    wget \
    zip \
    unzip \
    && apt-get clean

# create ssh key
RUN echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
