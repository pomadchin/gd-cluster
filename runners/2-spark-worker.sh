#!/bin/bash

for i in "$@"
do
case $i in
    -t=*|--tag=*)
    TAG="${i#*=}"
    shift
    ;;
    -v=*|--volume=*)
    VOLUME="${i#*=}"
    shift
    ;;
    -hma=*|--hadoop-master-address=*)
    HADOOP_MASTER_ADDRESS="${i#*=}"
    shift
    ;;
    -sm=*|--spark-master=*)
    SPARK_MASTER="${i#*=}"
    shift
    ;;
    *)
    ;;
esac
done

docker run \
  --name=spark-worker \
  --net=host \
  --detach \
  --restart=always \
  --env="SPARK_DAEMON_MEMORY=2g" \
  --env="SPARK_SUBMIT_DRIVER_MEMORY=1g" \
  --env="SPARK_WORKER_CORES=8" \
  --env="SPARK_WORKER_MEMORY=16g" \
  --env="HADOOP_MASTER_ADDRESS=${HADOOP_MASTER_ADDRESS}" \
  --env="SPARK_MASTER=${SPARK_MASTER}" \
  --volume=${VOLUME:-"/data/gt/spark"}:/data/spark \
  geotrellis/geodocker-spark:${TAG:-"latest"} worker
