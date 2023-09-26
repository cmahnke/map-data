#!/bin/sh

PLANETILER_IMAGE="ghcr.io/cmahnke/projektemacher-maps/planetiler:latest-data"
NAME=`date |md5`

docker pull $PLANETILER_IMAGE
docker create --name $NAME $PLANETILER_IMAGE
docker cp $NAME:/opt/planetiler .
mv planetiler/planetiler-*-with-deps.jar .
rm -rf planetiler
docker rm -f $NAME
docker rmi $PLANETILER_IMAGE
