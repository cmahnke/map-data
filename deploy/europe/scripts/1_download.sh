#!/usr/bin/env bash

if [ -z "$INPUT_URL" ] ; then
  INPUT_URL=https://download.geofabrik.de/europe-latest.osm.pbf
fi

if [ -z "$OSMCONVERT" ] ; then
  OSMCONVERT=osmconvert
fi

if [ -z "$SOURCE_DIR" ] ; then
  SOURCE_DIR=data/sources
fi

if [ -z "$INPUT" ] ; then
  INPUT=$SOURCE_DIR/input.o5m
fi


wget -N -P data/sources/ "https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip"
wget -N -P data/sources/ "https://dev.maptiler.download/geodata/omt/lake_centerline.shp.zip"
wget -N -P data/sources/ "https://dev.maptiler.download/geodata/omt/natural_earth_vector.sqlite.zip"

if [ ! -r "$INPUT" ] ; then
  echo "Download and convert $INPUT_URL to $INPUT"
  #curl -s "$INPUT_URL" |$OSMCONVERT - -o=$INPUT
  wget -O- "$INPUT_URL" |$OSMCONVERT - -o=$INPUT
else
  echo "$INPUT exists at `pwd`"
fi
