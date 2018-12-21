FROM bwjdk:11

USER root

ENV ES_VER 6.5.4

RUN sysctl -w vm.max_map_count=262144
RUN swapoff -a

# setup application deployment directories
RUN mkdir -p /bwtmp
RUN mkdir -p /opt/elasticsearch
RUN mkdir -p /data

RUN curl \
    https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VER.tar.gz \
    --output /bwtmp/elasticsearch.tar.gz

RUN tar xzf /bwtmp/elasticsearch.tar.gz -C /bwtmp && \
    cp -af /bwtmp/elasticsearch-$ES_VER/* /opt/elasticsearch && \
    rm -rf /bwtmp/*

#RUN mkdir -p /opt/elasticsearch/config/certs
#COPY conf/*.p12 /opt/elasticsearch/config/certs/

COPY conf/es.jvm.options /opt/elasticsearch/config/jvm.options
COPY bin/es.sh /opt/elasticsearch/bin/

RUN useradd elastic
RUN usermod -aG sudo elastic
RUN chown -R elastic /opt
RUN chown -R elastic /data

USER elastic

ENV ES_HEAP 1g

VOLUME /data

ENTRYPOINT ["/opt/elasticsearch/bin/es.sh"]
# CMD ["test"]
