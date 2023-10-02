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

if [ -z "$OSP_REMOVE_TAGS" ] ; then
  OSP_REMOVE_TAGS=osp-proc-remove-tags
fi

if test -n "$1" ; then
  OUT="$1-clean.osm.pbf"
  if [ "$METHOD" == "osmfilter" ] ; then
    $OSMCONVERT $1 -o=$1.o5m && \
    $OSMFILTER $1.o5m --parameter-file=../config/osmfilter-clean |$OSMCONVERT - --out-pbf -o=$OUT
  elif [ "$METHOD" = "osmium" ] ; then
    OUT_FILTER="$1-clean1.osm.pbf"
    echo "Filtereing '$1' into '$OUT_FILTER'" >&2
    $OSMIUM tags-filter -i -o $OUT_FILTER $1 'a/building' 'natural=tree'
    echo "Removing $1" >&2
    rm $1
    echo "Filtering '$OUT_FILTER' into '$OUT'" >&2
    $OSP_REMOVE_TAGS $OUT_FILTER -e ../config/osp-proc-remove-tags-clean -o $OUT
    rm $OUT_FILTER
  fi
  echo "$OUT"
fi
