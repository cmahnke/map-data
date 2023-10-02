export INPUT_URL=https://download.geofabrik.de/europe/monaco-latest.osm.pbf
# Use ',' to seperate coords
export BBOX=""
export DATA_DIR=data
export SOURCE_DIR=$DATA_DIR/sources
export INPUT=$SOURCE_DIR/input.pbf
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export METHOD=osmium
export WGET="wget --progress=bar:force:noscroll --progress=dot:mega"
export OSMCONVERT="./osmconvert"
export OSMFILTER="./osmfilter"
export OSMIUM="/opt/homebrew/bin/osmium"
export OSP_REMOVE_TAGS="exit 1"
export MBUTIL="/opt/homebrew/bin/mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER="exit 1"
export PLANETILER_OPTS="--polygon=$SOURCE_DIR/europe.poly"

export TILE_COMPRESSION=gzip
export MAX_ZOOM=13
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
