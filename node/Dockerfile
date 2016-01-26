FROM ubuntu:14.04

USER root

# update ubuntu repo for China
RUN rm /etc/apt/sources.list
ADD ./sources.list.trusty /etc/apt/sources.list
#RUN apt-get clean && \
  #apt-get update --fix-missing

# install ubuntu packages
RUN apt-get update \
    && apt-get install -y build-essential \
    libkrb5-dev \
    curl \
    python \
    git \
    && apt-get clean

# set node version
ENV NODE_VERSION 4.2.6

# download node.js
RUN mkdir -p /opt/tools
RUN cd \
    && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /opt/tools/ \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
    && ln -s /opt/tools/node-v$NODE_VERSION-linux-x64 /opt/tools/nodejs

# set path for node realated commands
ENV PATH $PATH:/opt/tools/nodejs/bin

# upgrade npm
RUN npm install -g npm
