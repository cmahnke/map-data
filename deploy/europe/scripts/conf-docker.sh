export INPUT_URL=https://download.geofabrik.de/europe/monaco-latest.osm.pbf
# Use ',' to seperate coords
export BBOX=""
export SOURCE_DIR=data/sources
export INPUT=$SOURCE_DIR/input.pbf
export POSTPROCESSED=$SOURCE_DIR/input.pbf
export TILES_DIR=tiles
export METHOD=osmium
export WGET"=wget --progress=bar:force:noscroll"
export OSMCONVERT="docker run -it -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmctools:latest /opt/osmctools/bin/osmconvert"
export OSMFILTER="docker run -it -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmctools:latest /opt/osmctools/bin/osmfilter"
export OSMIUM="docker run -it -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmium:latest /opt/osmium/bin/osmium"
export OSP_REMOVE_TAGS="docker run -it -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/osmium:latest /opt/osmium/bin/osp-proc-remove-tags"
export MBUTIL="docker run -it -v `pwd`:`pwd` -w `pwd` ghcr.io/cmahnke/map-tools/mbutil:latest /usr/bin/mb-util"
export COVERAGE=`basename $INPUT_URL`
export PLANETILER="exit 1"
export PLANETILER_OPTS="--polygon=$SOURCE_DIR/europe.poly"

export TILE_COMPRESSION=gzip
export MAX_ZOOM=13
export EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
