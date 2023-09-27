#!/usr/bin/env bash

if [ -z "$PLANETILER" ] ; then
  PLANETILER="java -Xmx4g -jar /opt/planetiler/planetiler-*-with-deps.jar"
fi

if [ -z "$POSTPROCESSED" ] ; then
  POSTPROCESSED=$SOURCE_DIR/input.pbf
fi

if [ -z "$TILES" ] ; then
  TILES=tiles
fi

echo "Starting Planetiler" && \
$PLANETILER --download=false --languages=de,en --use_wikidata=false --osm-path=$POSTPROCESSED --free_water_polygons_after_read=true --free_natural_earth_after_read=true --free_osm_after_read=true --free_lake_centerlines_after_read=true --tile_compression=${TILE_COMPRESSION} --maxzoom=${MAX_ZOOM} --render_maxzoom=${MAX_ZOOM} --building_merge_z13=false --exclude-layers=${EXCLUDE_LAYERS} $PLANETILER_OPTS
if [ $? -ne 0 ] ; then
  echo "Processig error"
  exit 1
fi

rm -f $POSTPROCESSED
$MBUTIL --image_format=pbf data/output.mbtiles $TILES
