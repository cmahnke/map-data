#!/usr/bin/env bash

if [ -z "$TILES" ] ; then
  TILES=tiles
fi

if [ -z "$DATA_DIR" ] ; then
  DATA_DIR=data
fi

if [ -n "$BBOX" ] ; then
  echo "[`echo $BBOX |tr ' ' ','`]" > $DATA_DIR/bbox.json
fi
