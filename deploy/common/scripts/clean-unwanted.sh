#!/usr/bin/env bash

if [ -z "$METHOD" ] ; then
  METHOD=osmfilter
fi

if test -n "$1" ; then
  OUT="$1-wo-buildings.osm.pbf"
  if [ "$METHOD" == "osmfilter" ] ; then
    /opt/osmctools/bin/osmconvert $1 -o=$1.o5m && \
    /opt/osmctools/bin/osmfilter $1.o5m --parameter-file=../config/osmfilter-clean |/opt/osmctools/bin/osmconvert - --out-pbf -o=$OUT
  elif [ "$METHOD" = "osmium" ] ; then

    /opt/osmium/bin/osmium tags-filter -i -o $OUT $1 building

  fi
  echo "$OUT"
fi
