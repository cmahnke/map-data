#!/usr/bin/env bash

if [ -z "$SOURCE_DIR" ] ; then
  SOURCE_DIR=data/sources
fi

if [ -z "$WGET" ] ; then
  WGET=wget
fi

if [ -z "$SOURCE_DIR" ] ; then
  SOURCE_DIR=data/sources
fi

$WGET -N -P "$SOURCE_DIR" "https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip"
$WGET -N -P "$SOURCE_DIR" "https://dev.maptiler.download/geodata/omt/lake_centerline.shp.zip"
$WGET -N -P "$SOURCE_DIR" "https://dev.maptiler.download/geodata/omt/natural_earth_vector.sqlite.zip"
