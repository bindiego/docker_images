FROM bwubuntu:18.04

USER root

# set jdk version
ENV GO_FILE go1.12.9.linux-amd64.tar.gz

# download jdk 
RUN mkdir -p /opt/tools
RUN cd \
  && curl -v -j -k -L \
    https://dl.google.com/go/$GO_FILE \
    > $GO_FILE \
  && tar -xzf "$GO_FILE" -C /opt/tools/ \
  && rm "$GO_FILE"

# set path for java realated commands
ENV GOROOT /opt/tools/go
ENV PATH $PATH:$GOROOT/bin

