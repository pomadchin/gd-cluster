FROM daunnc/geodocker-zookeeper:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ENV HADOOP_VERSION 2.7.1
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin

RUN set -x && \
    mkdir -p $HADOOP_PREFIX && \
    curl -# http://apache-mirror.rbc.ru/pub/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -xz -C ${HADOOP_PREFIX} --strip-components=1    

COPY ./fs /
RUN chown -R hadoop:hadoop $HADOOP_PREFIX

USER hadoop
ENV USER hadoop
ENV HOME /user/hadoop

WORKDIR "${HADOOP_HOME}"
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
