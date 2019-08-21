FROM alpine:3

USER root

# RUN apk add --update openssh
RUN apk add --update openssh-client curl tar git

# create ssh key
RUN echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
