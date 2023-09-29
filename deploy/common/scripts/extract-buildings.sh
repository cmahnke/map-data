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
  OUT="$1-extracted.osm.pbf"
  if [ "$METHOD" == "osmfilter" ] ; then
    #echo "Extracting remaining buildings from $1" && \
    $OSMCONVERT $1 -o=$1.o5m && \
    #/opt/osmctools/bin/osmfilter $1.o5m --keep='building=yes and historic=*' --keep='building=yes and name=*' --keep='building=yes and tourism=artwork' --keep='building=yes and architect*=*' --keep='building:architecture=*' |/opt/osmctools/bin/osmconvert - -o=$OUT
    $OSMFILTER $1.o5m --parameter-file=../config/osmfilter-buildings |$OSMCONVERT - -o=$OUT
    rm $1.o5m
  elif [ "$METHOD" = "osmium" ] ; then
    $OSMIUM tags-filter -o "$1-all-extracted.osm.pbf" "$1" a/building
    $OSMIUM tags-filter -o "$OUT" "$1-all-extracted.osm.pbf" 'historic' 'name' 'tourism=artwork' 'architect:*' 'architect' 'building:architecture' 'memorial'
    rm "$1-all-extracted.osm.pbf"
  fi
  echo "$OUT"
fi
