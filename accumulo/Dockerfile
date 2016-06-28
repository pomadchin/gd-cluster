FROM daunnc/geodocker-hadoop:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ENV ACCUMULO_VERSION 1.7.2
ENV ACCUMULO_HOME /opt/accumulo
ENV ACCUMULO_CONF_DIR $ACCUMULO_HOME/conf
ENV PATH $PATH:$ACCUMULO_HOME/bin

RUN set -x && \
    mkdir -p ${ACCUMULO_HOME} ${ACCUMULO_CONF_DIR} && \
    curl -# http://apache-mirror.rbc.ru/pub/apache/accumulo/${ACCUMULO_VERSION}/accumulo-${ACCUMULO_VERSION}-bin.tar.gz | tar -xz -C ${ACCUMULO_HOME} --strip-components=1 && \
    cp ${ACCUMULO_HOME}/conf/examples/3GB/standalone/* ${ACCUMULO_CONF_DIR}/

WORKDIR "${ACCUMULO_HOME}"

# Build native bindings for accumulo performance
RUN yum install -y make gcc-c++
RUN bash -c "bin/build_native_library.sh"

COPY ./fs /

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
