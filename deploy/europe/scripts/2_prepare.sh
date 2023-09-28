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

#TODO: Work with o5c file (osmfilter)
if [ "${BBOX}" != '' ] && [ "${BBOX}" != 'null' ] ; then
  echo "Bbox handling in prepare.sh is disabled"
  #exit 1
  #$OSMIUM extract --bbox="$BBOX" data/sources/input.osm.pbf --output=data/sources/input-bb.osm.pbf
  #rm -f data/sources/input.osm.pbf
  #mv data/sources/input-bb.osm.pbf data/sources/input.osm.pbf
fi

# See https://wiki.openstreetmap.org/wiki/Osmfilter#Parameter_File
echo "Extracting remaining buildings from $INPUT to $OUTPUT_BUILDINGS"
$OSMFILTER $INPUT --keep='building=yes and historic=*' --keep='building=yes and name=*' --keep='building=yes and tourism=artwork' --keep='building=yes and architect:*=*' --keep='building=yes and architect=*' --keep='building:architecture=*' |$OSMCONVERT - --out-pbf -o=$OUTPUT_BUILDINGS
echo "Created buildings at '$OUTPUT_BUILDINGS' `$SIZE_CMD $OUTPUT_BUILDINGS`"
$OSMFILTER $INPUT --drop='building=' | $OSMCONVERT - --out-pbf -o=$OUTPUT_WO_BUILDINGS
echo "Removing $INPUT"
rm $INPUT

echo "Storage Statistics"
df -h

# Use `osmium` if there isn't enough memory
#$OSMIUM tags-filter -i -o $OUT $1 a/building
echo "Removed buildings from '$OUTPUT_WO_BUILDINGS' `$SIZE_CMD $OUTPUT_WO_BUILDINGS`"
echo "Merge remaining buildings back"
$OSMIUM merge -O --fsync $OUTPUT_WO_BUILDINGS $OUTPUT_BUILDINGS -o $POSTPROCESSED
rm $OUTPUT_WO_BUILDINGS $OUTPUT_BUILDINGS
