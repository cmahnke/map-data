export INPUT_URL=https://download.geofabrik.de/europe/monaco-latest.osm.pbf
export BBOX=""
export SOURCE_DIR=data/sources
export INPUT=$SOURCE_DIR/input.o5m
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export WGET=wget
export OSMCONVERT="docker run -a stdin -a stdout -a stderr -i -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmctools:latest /opt/osmctools/bin/osmconvert"
export OSMFILTER="docker run -a stdin -a stdout -a stderr -i -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmctools:latest /opt/osmctools/bin/osmfilter"
export OSMIUM="docker run -a stdin -a stdout -a stderr -i -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmium:latest /opt/osmium/bin/osmium"
export MBUTIL="docker run -a stdin -a stdout -a stderr -i -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/mbutil:latest /usr/bin/mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER=""

export TILE_COMPRESSION=gzip
export MAX_ZOOM=14
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
