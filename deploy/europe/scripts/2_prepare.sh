#!/usr/bin/env bash

set -eo pipefail

if [ -z "$OSMCONVERT" ] ; then
  OSMCONVERT=osmconvert
fi

if [ -z "$OSMFILTER" ] ; then
  OSMFLTER=osmfilter
fi

if [ -z "$OSMIUM" ] ; then
  OSMIUM=osmium
fi

if [ -z "$SOURCE_DIR" ] ; then
  SOURCE_DIR=data/sources
fi

if [ -z "$INPUT" ] ; then
  INPUT=$SOURCE_DIR/input.o5m
fi

if [ -z "$POSTPROCESSED" ] ; then
  POSTPROCESSED=$SOURCE_DIR/input.pbf
fi

if [ -z "$OUTPUT_BUILDINGS" ] ; then
  OUTPUT_BUILDINGS="$INPUT-extracted-buildings.osm.pbf"
fi

if [ -z "$OUTPUT_WO_BUILDINGS" ] ; then
  OUTPUT_WO_BUILDINGS="$INPUT-wo-buildings.osm.pbf"
fi

if [ ! -r "$INPUT" ] ; then
  echo "Input file $INPUT missing"
  exit 1
fi

if [ -z "$METHOD" ] ; then
  export METHOD=osmium
fi

if [ "${BBOX}" != '' ] && [ "${BBOX}" != 'null' ] && [ "$METHOD" == 'osmium' ] ; then
  BBOX=$(echo $BBOX |tr ' ' ',')
  TMP=$INPUT-bb.osm.pbf
  echo "Extracting Bbox $$BBOX from $INPUT"
  $OSMIUM extract --bbox="$BBOX" $INPUT --output=$TMP
  rm -f $INPUT
  mv $TMP $INPUT
fi

# See https://wiki.openstreetmap.org/wiki/Osmfilter#Parameter_File
echo "Extracting remaining buildings from $INPUT to $OUTPUT_BUILDINGS"
OUTPUT_BUILDINGS=$(./extract-buildings.sh $INPUT)
echo "Created buildings at '$OUTPUT_BUILDINGS' `$SIZE_CMD $OUTPUT_BUILDINGS`"

echo "Cleaning data file"
#$OSMFILTER $INPUT --parameter-file=../config/osmfilter-clean | $OSMCONVERT - --out-pbf -o=$OUTPUT_WO_BUILDINGS
OUTPUT_WO_BUILDINGS=$(./clean-unwanted.sh $INPUT)

echo "Storage Statistics"
df -h

# Use `osmium` if there isn't enough memory
#$OSMIUM tags-filter -i -o $OUT $1 a/building
echo "Removed buildings from '$OUTPUT_WO_BUILDINGS' `$SIZE_CMD $OUTPUT_WO_BUILDINGS`"
echo "Merge remaining buildings back"
$OSMIUM merge -O --fsync $OUTPUT_WO_BUILDINGS $OUTPUT_BUILDINGS -o $POSTPROCESSED
rm $OUTPUT_WO_BUILDINGS $OUTPUT_BUILDINGS

echo "Storage Statistics"
ls -R `dirname $INPUT`
du -h `dirname $INPUT`/*
df -h
