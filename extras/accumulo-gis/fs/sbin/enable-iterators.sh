#!/bin/bash

ACCUMULO_USER="root"

# Arg parsing
if [ -z "${1}" ]; then
  echo "No arguments provided - please specify either geowave or geomesa iterators as well as an appropriate accumulo namespace"
  exit 1
elif [ "${1}" = "geowave" ]; then
  ITERATORS="geowave"
elif [ "${1}" = "geomesa" ]; then
  ITERATORS="geomesa"
else
  echo "Invalid iterator argument. Ensure that the first argument provided is either 'geowave' or 'geomesa'."
  exit 1
fi

if [ -z "${2}" ]; then
  echo "No namespace selected, using default ${ITERATORS} namespace, '${ITERATORS}'."
  NAMESPACE="${ITERATORS}"
else
  NAMESPACE="${2}"
fi

# Ensure that the proper path structure is in place
hadoop fs -mkdir /accumulo-classpath/${NAMESPACE}

# GeoWave/Mesa specific operations
if [ "${ITERATORS}" = "geomesa" ]; then
  hadoop fs -put ${TMP_LIB_DIR}joda-time-2.3.jar \
    /accumulo/classpath/${NAMESPACE}/joda-time-2.3.jar
  hadoop fs -put ${TMP_LIB_DIR}geomesa-accumulo-distributed-runtime-${GEOMESA_VERSION}.jar \
    /accumulo/classpath/${NAMESPACE}/geomesa-accumulo-distributed-runtime-${GEOMESA_VERSION}.jar
elif [ "${ITERATORS}" = "geowave" ]; then
  hadoop fs -put ${TMP_LIB_DIR}geowave-accumulo.jar \
    /accumulo/classpath/${NAMESPACE}/geowave-accumulo.jar
fi

# Register accumulo namespace
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} \
  -e "createnamespace ${NAMESPACE}"
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} \
  -e "grant NameSpace.CREATE_TABLE -ns ${NAMESPACE} -u ${ACCUMULO_USER}"
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} \
  -e "config -s general.vfs.context.classpath.${NAMESPACE}=hdfs://HADOOP_MASTER_ADDRESS:8020/accumulo/classpath/${NAMESPACE}/[^.].*.jar"
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} \
  -e "config -ns ${NAMESPACE} -s table.classpath.context=${NAMESPACE}"

