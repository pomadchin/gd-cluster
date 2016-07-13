FROM daunnc/geodocker-accumulo:latest

MAINTAINER Pomadchin Grigory, daunnc@gmail.com

ENV GEOMESA_VERSION="1.2.2"
ENV GEOWAVE_VERSION="0.9.1"
ENV TMP_LIB_DIR="/tmp/"
ENV GEOMESA_HOME=/opt/geomesa-${GEOMESA_VERSION}/dist/tools/geomesa-tools-${GEOMESA_VERSION}

COPY ./fs /

# GeoMesa GIS iterators for accumulo
RUN wget -qO- http://repo.locationtech.org/content/repositories/geomesa-releases/org/locationtech/geomesa/geomesa-dist/${GEOMESA_VERSION}/geomesa-dist-${GEOMESA_VERSION}-bin.tar.gz \
  | tar xvz -C /opt/
RUN wget https://bitbucket.org/pomadchin/binary/raw/c5b0ea0aa98de751f56848d9915a9b6a4ee8f3df/geo/joda-time-2.3.jar \
  -O ${TMP_LIB_DIR}joda-time-2.3.jar
RUN cp /opt/geomesa-${GEOMESA_VERSION}/dist/accumulo/geomesa-accumulo-distributed-runtime-${GEOMESA_VERSION}.jar \
  ${TMP_LIB_DIR}geomesa-accumulo-distributed-runtime-${GEOMESA_VERSION}.jar
RUN tar -xf /opt/geomesa-${GEOMESA_VERSION}/dist/tools/geomesa-tools-${GEOMESA_VERSION}-bin.tar.gz \
  -C /opt/geomesa-${GEOMESA_VERSION}/dist/tools/
RUN rm -rf /opt/geomesa-${GEOMESA_VERSION}/dist/tools/geomesa-tools-${GEOMESA_VERSION}-bin.tar.gz

# Install third party libraries which have problematic IP
RUN ${GEOMESA_HOME}/bin/install-jai
RUN ${GEOMESA_HOME}/bin/install-jline

# GeoWave GIS iterators for accumulo + commandline
RUN rpm -Uvh --replacepkgs http://s3.amazonaws.com/geowave-rpms/release/noarch/geowave-repo-1.0-3.noarch.rpm
RUN yum --enablerepo=geowave install -y geowave-${GEOWAVE_VERSION}-apache-accumulo
RUN yum --enablerepo=geowave install -y geowave-${GEOWAVE_VERSION}-apache-tools
RUN cp /usr/local/geowave/accumulo/geowave-accumulo.jar ${TMP_LIB_DIR}geowave-accumulo.jar

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
