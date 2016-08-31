FROM ubuntu:16.04

USER root

# update ubuntu repo for China
RUN rm /etc/apt/sources.list
ADD ./sources.list.xenial /etc/apt/sources.list
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

# set jdk version
ENV JDK_FILE jdk-8u101-linux-x64.tar.gz

# download jdk 
RUN mkdir -p /opt/tools
RUN cd \
  && curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u101-b13/$JDK_FILE \
    > $JDK_FILE \
  && tar -xzf "$JDK_FILE" -C /opt/tools/ \
  && rm "$JDK_FILE" \
  && ln -s /opt/tools/jdk1.8.0_101 /opt/tools/jdk

# set maven version
ENV MAVEN_VERSION 3.3.9
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /opt/tools \
  && ln -s /opt/tools/apache-maven-$MAVEN_VERSION /opt/tools/mvn

# set path for java realated commands
ENV JAVA_HOME /opt/tools/jdk
ENV M2_HOME /opt/tools/mvn
ENV PATH $PATH:/opt/tools/jdk/bin:/opt/tools/mvn/bin

# since the user is root, simply set the local cache and you can mount extrals
VOLUME /root/.m2
