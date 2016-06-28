#!/bin/bash

for i in "$@"
do
case $i in
    -t=*|--tag=*)
    TAG="${i#*=}"
    shift
    ;;
    -hma=*|--hadoop-master-address=*)
    HADOOP_MASTER_ADDRESS="${i#*=}"
    shift
    ;;
    *)
    ;;
esac
done

docker run \
  --name=spark-master \
  --net=host \
  --detach \
  --restart=always \
  --env="SPARK_DAEMON_MEMORY=2g" \
  --env="SPARK_SUBMIT_DRIVER_MEMORY=1g" \
  --env="HADOOP_MASTER_ADDRESS=${HADOOP_MASTER_ADDRESS}" \
  geotrellis/geodocker-spark:${TAG:-"latest"} master
