export INPUT_URL=https://download.geofabrik.de/europe/monaco-latest.osm.pbf
# Use ',' to seperate coords
export BBOX=""
export SOURCE_DIR=data/sources
export INPUT=$SOURCE_DIR/input.o5m
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export WGET=wget
export OSMCONVERT="./osmconvert"
export OSMFILTER="./osmfilter"
export OSMIUM="/opt/homebrew/bin/osmium"
export MBUTIL="/opt/homebrew/bin/mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER=""

export TILE_COMPRESSION=gzip
export MAX_ZOOM=14
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
