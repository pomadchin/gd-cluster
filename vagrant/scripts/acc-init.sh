docker run --rm \
  --name=accumulo-init \
  --net=host \
  --env="HADOOP_MASTER_ADDRESS=master" \
  --env="ACCUMULO_ZOOKEEPERS=master,slave-1,slave-2" \
  --env="ACCUMULO_SECRET=secret" \
  --env="ACCUMULO_PASSWORD=GisPwd" \
  geotrellis/geodocker-accumulo-master:latest \
  bash -c "hadoop fs -mkdir -p /accumulo-classpath && accumulo init --instance-name gis --password GisPwd"
