FROM geodocker-pbase:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ENV ZOOKEEPER_VERSION 3.4.6
ENV ZOOKEEPER_HOME /opt/zookeeper
ENV ZOOKEEPER_DATA /data/zookeeper
ENV ZOOKEEPER_CONF_DIR $ZOOKEEPER_HOME/conf
ENV ZOO_LOG4J_PROP WARN,CONSOLE
ENV PATH $PATH:$ZOOKEEPER_HOME/bin

RUN set -x && \
    mkdir -p $ZOOKEEPER_HOME $ZOOKEEPER_DATA && \
    curl -# http://apache-mirror.rbc.ru/pub/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xz -C ${ZOOKEEPER_HOME} --strip-components=1

COPY ./fs /

WORKDIR "${ZOOKEEPER_HOME}"
# EXPOSE 2181 2888 3888
VOLUME [ "$ZOOKEEPER_DATA" ]

RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
CMD [ "zkServer.sh", "start-foreground" ]
