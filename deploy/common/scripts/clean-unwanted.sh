#!/usr/bin/env bash

if [ -z "$METHOD" ] ; then
  METHOD=osmfilter
fi

if [ -z "$OSMCONVERT" ] ; then
  OSMCONVERT=osmconvert
fi

if [ -z "$OSMFILTER" ] ; then
  OSMFLTER=osmfilter
fi

if [ -z "$OSMIUM" ] ; then
  OSMIUM=osmium
fi

if test -n "$1" ; then
  OUT="$1-wo-buildings.osm.pbf"
  if [ "$METHOD" == "osmfilter" ] ; then
    $OSMCONVERT $1 -o=$1.o5m && \
    $OSMFILTER $1.o5m --parameter-file=../config/osmfilter-clean |$OSMCONVERT - --out-pbf -o=$OUT
  elif [ "$METHOD" = "osmium" ] ; then

    $OSMIUM tags-filter -i -o $OUT $1 building

  fi
  echo "$OUT"
fi
