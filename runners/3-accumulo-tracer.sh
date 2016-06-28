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
    -az=*|--accumulo-zookeepers=*)
    ACCUMULO_ZOOKEEPERS="${i#*=}"
    shift
    ;;
    -as=*|--accumulo-secret=*)
    ACCUMULO_SECRET="${i#*=}"
    shift
    ;;
    -ap=*|--accumulo-password=*)
    ACCUMULO_PASSWORD="${i#*=}"
    shift
    ;;
    *)
    ;;
esac
done

docker run \
  --name=accumulo-tracer \
  --net=host \
  --detach \
  --restart=always \
  --env="HADOOP_MASTER_ADDRESS=${HADOOP_MASTER_ADDRESS}" \
  --env="ACCUMULO_ZOOKEEPERS=${ACCUMULO_ZOOKEEPERS}" \
  --env="ACCUMULO_SECRET=${ACCUMULO_SECRET}" \
  --env="ACCUMULO_PASSWORD=${ACCUMULO_PASSWORD}" \
  geotrellis/geodocker-accumulo:${TAG:-"latest"} tracer
