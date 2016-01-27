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
ENV JDK_FILE jdk-8u71-linux-x64.tar.gz

# download jdk 
RUN mkdir -p /opt/tools
RUN cd \
  && curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u71-b15/$JDK_FILE \
    > $JDK_FILE \
  && tar -xzf "$JDK_FILE" -C /opt/tools/ \
  && rm "$JDK_FILE" \
  && ln -s /opt/tools/jdk1.8.0_71 /opt/tools/jdk

# set path for node realated commands
ENV JAVA_HOME /opt/tools/jdk
ENV PATH $PATH:/opt/tools/jdk/bin
