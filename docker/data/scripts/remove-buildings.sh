#!/bin/sh

if test -n "$1" ; then
  OUT="$1-wo-buildings.osm.pbf"
  /opt/osmium/bin/osmium tags-filter -i -o $OUT $1 a/building
  echo "$OUT"
fi
