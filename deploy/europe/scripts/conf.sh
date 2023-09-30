export INPUT_URL=https://download.geofabrik.de/europe-latest.osm.pbf
# Use ',' to seperate coords
export BBOX=""
export SOURCE_DIR=data/sources
export INPUT=$SOURCE_DIR/input.pbf
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export METHOD=osmium
export WGET=wget
export OSMCONVERT="/opt/osmctools/bin/osmconvert"
export OSMFILTER="/opt/osmctools/bin/osmfilter"
export OSMIUM="/opt/osmium/bin/osmium"
export OSP_REMOVE_TAGS="/opt/osmium/bin/osp-proc-remove-tags"
export MBUTIL="mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER="java -Xmx5g -jar /opt/planetiler/planetiler-*-with-deps.jar"
export PLANETILER_OPTS="--polygon=$SOURCE_DIR/europe.poly"

export TILE_COMPRESSION=gzip
export MAX_ZOOM=14
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
