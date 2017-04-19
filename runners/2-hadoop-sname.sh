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
    *)
    ;;
esac
done

docker run \
  --name=hadoop-sname \
  --net=host \
  --volume=${VOLUME:-"/data/gt/hdfs"}:/data/hdfs \
  --detach \
  --restart=always \
  --env="HADOOP_MASTER_ADDRESS=${HADOOP_MASTER_ADDRESS}" \
  geotrellis/geodocker-hadoop:${TAG:-"latest"} sname
