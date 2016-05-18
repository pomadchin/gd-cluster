FROM daunnc/geodocker-hadoop-base:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ARG WITH_GEO_ITERATORS

ENV WITH_GEO_ITERATORS ${WITH_GEO_ITERATORS:-false}
ENV ACCUMULO_VERSION 1.7.1
ENV ACCUMULO_HOME /opt/accumulo
ENV ACCUMULO_CONF_DIR $ACCUMULO_HOME/conf
ENV PATH $PATH:$ACCUMULO_HOME/bin

USER root
RUN set -x && \
    mkdir -p ${ACCUMULO_HOME} ${ACCUMULO_CONF_DIR} && \
    curl -# http://apache-mirror.rbc.ru/pub/apache/accumulo/${ACCUMULO_VERSION}/accumulo-${ACCUMULO_VERSION}-bin.tar.gz | tar -xz -C ${ACCUMULO_HOME} --strip-components=1 && \
    cp ${ACCUMULO_HOME}/conf/examples/3GB/standalone/* ${ACCUMULO_CONF_DIR}/

COPY ./fs /
RUN chown -R hadoop:hadoop $ACCUMULO_HOME
USER hadoop

# Geo Iterators
RUN /sbin/load-iterators.sh

WORKDIR "${ACCUMULO_HOME}"
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
