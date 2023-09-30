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

    $OSMIUM tags-filter -i -o $OUT $1 'building' 'natural=tree'
    #Tags to remove 'addr:*' surface source service
    # 'aeroway' 'office' 'cuisine' 'sport' 'public_transport'

  fi
  echo "$OUT"
fi
