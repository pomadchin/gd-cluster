# Registering a namespace

As of Accumulo 1.6, the ability to namespace tables means that we can
have conflicting sets of iterators for the same cluster. Unfortunately,
this necessitates registration on a per-namespace basis. To register the
GIS iterators of your choosing, simply pass 'geowave <namespace>' or
'geomesa <namespace>' to the script at '/sbin/enable-iterators.sh'.
Remember that HDFS must be available for such a command to work, so give
the cluster some time to warm up before attempting.

'''bash
docker exec -it <accumulo-gis-container-name> \
  /sbin/enable-iterators.sh geowave geowave
'''

