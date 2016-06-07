FROM daunnc/geodocker-hadoop:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ENV SPARK_HOME /opt/spark
ENV SPARK_CONF_DIR $SPARK_HOME/conf
ENV PATH $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

RUN set -x && \
    mkdir -p $SPARK_HOME $SPARK_CONF_DIR && \
    curl -# http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C ${SPARK_HOME} --strip-components=1

COPY ./fs /

RUN mkdir -p /data/spark

VOLUME [ "/data/spark" ]

WORKDIR "${SPARK_HOME}"
RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh" ]

