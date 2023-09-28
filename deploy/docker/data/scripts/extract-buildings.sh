#!/bin/sh

if test -n "$1" ; then
  OUT="$1-extracted.osm.pbf"
  #echo "Extracting remaining buildings from $1" && \
  /opt/osmctools/bin/osmconvert $1 -o=$1.o5m && \
  #/opt/osmctools/bin/osmfilter $1.o5m --keep='building=yes and historic=*' --keep='building=yes and name=*' --keep='building=yes and tourism=artwork' --keep='building=yes and architect*=*' --keep='building:architecture=*' |/opt/osmctools/bin/osmconvert - -o=$OUT
  /opt/osmctools/bin/osmfilter $1.o5m --parameter-file=../config/osmfilter-buildings |/opt/osmctools/bin/osmconvert - -o=$OUT

  rm $1.o5m
  echo "$OUT"
fi
