export INPUT_URL=https://download.geofabrik.de/europe-latest.osm.pbf
export BBOX=""
export SOURCE_DIR=data/sources
export INPUT=$SOURCE_DIR/input.o5m
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export OSMCONVERT="/opt/osmctools/bin/osmconvert"
export OSMFILTER="/opt/osmctools/bin/osmfilter"
export OSMIUM="/opt/osmium/bin/osmium"
export MBUTIL="mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER="java -Xmx5g -jar /opt/planetiler/planetiler-*-with-deps.jar"

export TILE_COMPRESSION=gzip
export MAX_ZOOM=14
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
