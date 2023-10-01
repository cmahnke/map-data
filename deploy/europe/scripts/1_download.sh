#!/usr/bin/env bash

if [ -z "$WGET" ] ; then
  WGET=wget
fi

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

if [ -z "$BBOX" ] ; then
  BBOX=""
fi

if [ -z "$METHOD" ] ; then
  METHOD=osmfilter
fi

sed -E 's/(.*)\/(.*)-latest.osm.pbf/$11\/$22.poly/g'
$WGET -N -P "$SOURCE_DIR" `echo $INPUT_URL |sed -E 's/(.*)\/(.*)-latest.osm.pbf/\1\/\2.poly/g'`

DOWNLOAD_CONVERT=""
if [ "${BBOX}" != '' ] && [ "${BBOX}" != 'null' && [ "$METHOD" == 'osmfilter' ] ] ; then
  DOWNLOAD_CONVERT="-b=$BBOX --complete-ways --complete-multipolygons --complete-boundaries"
fi

if [ ! -r "$INPUT" ] ; then
  echo "Download and convert $INPUT_URL to $INPUT"
  #curl -s "$INPUT_URL" |$OSMCONVERT - -o=$INPUT
  if [ "$METHOD" == "osmfilter" ] ; then
    $WGET -O- "$INPUT_URL" |$OSMCONVERT $DOWNLOAD_CONVERT - -o=$INPUT
  elif [ "$METHOD" = "osmium" ] ; then
    $WGET -O$INPUT "$INPUT_URL"
  fi

  echo "Downloaded $INPUT_URL to $INPUT `$SIZE_CMD $INPUT`"
else
  echo "$INPUT exists at `pwd`"
fi

echo "Storage Statistics"
ls -R `dirname $INPUT`
du -h `dirname $INPUT`/*
df -h
