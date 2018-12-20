FROM bwubuntu:18.04

USER root

# set jre version
ENV JRE_FILE server-jre-8u192-linux-x64.tar.gz

# download jre
RUN mkdir -p /opt/tools
RUN cd \
  && curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/$JRE_FILE \
    > $JRE_FILE \
  && tar -xzf "$JRE_FILE" -C /opt/tools/ \
  && rm "$JRE_FILE" \
  && ln -s /opt/tools/jdk1.8.0_192 /opt/tools/jre
  #&& ln -s /opt/tools/jre1.8.0_192 /opt/tools/jre

# set path for node realated commands
ENV JAVA_HOME /opt/tools/jre
ENV PATH $PATH:/opt/tools/jre/bin
