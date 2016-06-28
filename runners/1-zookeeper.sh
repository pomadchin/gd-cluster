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
    -zi=*|--zookeeper-id=*)
    ZOOKEEPER_ID="${i#*=}"
    shift
    ;;
    -zs1=*|--zookeeper-server-1=*)
    ZOOKEEPER_SERVER_1="${i#*=}"
    shift
    ;;
    -zs2=*|--zookeeper-server-2=*)
    ZOOKEEPER_SERVER_2="${i#*=}"
    shift
    ;;
    -zs3=*|--zookeeper-server-3=*)
    ZOOKEEPER_SERVER_3="${i#*=}"
    shift
    ;;
    *)
    ;;
esac
done

docker run \
  --name=zookeeper \
  --net=host \
  --volume=${VOLUME:-"/data/gt/zookeeper"}:/data/zookeeper \
  --env="ZOOKEEPER_ID=${ZOOKEEPER_ID}" \
  --env="ZOOKEEPER_SERVER_1=${ZOOKEEPER_SERVER_1}" \
  --env="ZOOKEEPER_SERVER_2=${ZOOKEEPER_SERVER_2}" \
  --env="ZOOKEEPER_SERVER_3=${ZOOKEEPER_SERVER_3}" \
  --detach \
  --restart=always \
  geotrellis/geodocker-zookeeper:${TAG:-"latest"}
