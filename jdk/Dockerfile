FROM bwubuntu:18.04

USER root

# set jdk version
ENV JDK_FILE jdk-11.0.2_linux-x64_bin.tar.gz


# download jdk 
RUN mkdir -p /opt/tools
RUN cd \
  && curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/$JDK_FILE \
    > $JDK_FILE \
  && tar -xzf "$JDK_FILE" -C /opt/tools/ \
  && rm "$JDK_FILE" \
  && ln -s /opt/tools/jdk-11.0.2 /opt/tools/jdk

# set maven version
ENV MAVEN_VERSION 3.6.0
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /opt/tools \
  && ln -s /opt/tools/apache-maven-$MAVEN_VERSION /opt/tools/mvn

# set gradle version
ENV GRADLE_VER 5.1.1
RUN curl -fsSL https://services.gradle.org/distributions/gradle-$GRADLE_VER-bin.zip > gradle-$GRADLE_VER-bin.zip && \
  unzip -d /opt/tools gradle-$GRADLE_VER-bin.zip && ln -s /opt/tools/gradle-$GRADLE_VER /opt/tools/gradle && \
  rm -rf gradle-$GRADLE_VER-bin.zip

# set path for java realated commands
ENV JAVA_HOME /opt/tools/jdk
ENV M2_HOME /opt/tools/mvn
ENV GRADLE_HOME /opt/tools/gradle
ENV PATH $PATH:/opt/tools/jdk/bin:/opt/tools/mvn/bin:/opt/tools/gradle/bin

# since the user is root, simply set the local cache and you can mount extras
VOLUME /root/.m2
VOLUME /root/.gradle
