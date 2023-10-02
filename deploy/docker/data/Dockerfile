# syntax=docker/dockerfile:experimental

# Which Planatiler image to use
ARG PLANATILER_IMAGE=ghcr.io/cmahnke/map-tools/planetiler:latest-data

FROM ${PLANATILER_IMAGE} AS planetiler
FROM ghcr.io/cmahnke/map-tools/osmium:latest AS osmium
FROM ghcr.io/cmahnke/map-tools/osmctools:latest AS osmctools

FROM alpine:3.18 as builder

ARG COVERAGE=central-europe.json
#tile_compression=gzip (the tile compression, one of [none, gzip])
ARG TILE_COMPRESSION=gzip
# Either 'files' otherwise mbtiles
ARG FORMAT=files
# Use this to reduce maximum zoom level
ARG MAX_ZOOM=14
#Exclude layers
ARG EXCLUDE_LAYERS=housenumber,aeroway,aerodrome_label,mountain_peak,waterway,transportation_name
# Filter buildings
ARG FILTER_BUILDINGS=true

ENV BUILD_DEPS="python3 py3-pip py3-yaml py3-requests openjdk17-jre-headless expat libbz2 zlib boost1.82-program_options lz4-libs geos zip jq bash" \
    BUILD_DIR=/tmp/build \
    DATA_DIR=/data \
    OSMCONVERT="/opt/osmctools/bin/osmconvert" \
    OSMFILTER="/opt/osmctools/bin/osmfilter" \
    OSMIUM="/opt/osmium/bin/osmium" \
    METHOD=osmium

COPY --from=planetiler /opt/planetiler /opt/planetiler
COPY --from=planetiler /tmp/build /tmp/build
COPY --from=osmium /opt/osmium /opt/osmium
COPY --from=osmctools /opt/osmctools /opt/osmctools

RUN --mount=target=/mnt/build-context \
    apk --update upgrade && \
    apk add --no-cache $RUN_DEPS $BUILD_DEPS && \
    mkdir -p $BUILD_DIR $DATA_DIR $BUILD_DIRdata/output/ && \
    cp -rL /mnt/build-context/deploy/docker/data/* $BUILD_DIR && \
    pip install -r $BUILD_DIR/requirements.txt && \
    PATH=$PATH:/opt/osmctools/bin:/opt/osmium/bin && \
    cd $BUILD_DIR/scripts && mkdir -p data/sources/ && \
    ./mktiles.py --print-cmd -v -m -c mktiles-docker.yaml -u ../coverages/${COVERAGE} && \
    BBOX=$(jq -r .bbox ../coverages/${COVERAGE} | tr ' ' ',') && \
    if test "${BBOX}" != '' && test "${BBOX}" != 'null' ; then \
      PLANETILER_OPTS="--bounds=${BBOX}" ; \
      /opt/osmium/bin/osmium extract --bbox="$BBOX" ./tmp/merged.osm.pbf --output=./tmp/merged-bb.osm.pbf && \
      rm -f ./tmp/merged.osm.pbf && \
      echo "[`echo $BBOX |tr ' ' ','`]" > $DATA_DIR/bbox.json && \
      mv ./tmp/merged-bb.osm.pbf ./tmp/merged.osm.pbf ; \
    else \
      PLANETILER_OPTS="" ; \
    fi && \
    if test "$FILTER_BUILDINGS" == 'some' ; then \
      BUILDINGS=$(./extract-buildings.sh ./tmp/merged.osm.pbf); \
    fi && \
    echo "Created buildings at '$BUILDINGS' $(stat -c %s $BUILDINGS)" && \
    if test "$FILTER_BUILDINGS" == 'true' -o "$FILTER_BUILDINGS" == 'some' ; then \
      WO_BUILDINGS=$(./clean-unwanted.sh ./tmp/merged.osm.pbf) && \
      echo "Removed buildings from '$WO_BUILDINGS' $(stat -c %s $WO_BUILDINGS)" && \
      rm -f ./tmp/merged.osm.pbf && \
      if test "$FILTER_BUILDINGS" == 'some' ; then \
        echo "Merge remaining buildings back" && \
        /opt/osmium/bin/osmium merge -O --fsync $WO_BUILDINGS $BUILDINGS -o data/sources/${COVERAGE}.osm.pbf && \
        rm -f $WO_BUILDINGS $BUILDINGS ; \
      else \
        rm -f ./tmp/merged.osm.pbf && \
        mv ./tmp/merged-filtered.osm.pbf data/sources/${COVERAGE}.osm.pbf ; \
      fi ; \
    else \
      mv ./tmp/merged.osm.pbf data/sources/${COVERAGE}.osm.pbf ; \
    fi && \
    echo "Moving data/sources/${COVERAGE}.osm.pbf to $BUILD_DIR/data/sources/${COVERAGE}.osm.pbf" && \
    mv data/sources/${COVERAGE}.osm.pbf $BUILD_DIR/data/sources/${COVERAGE}.osm.pbf && \
    cd $BUILD_DIR/ && \
    rm -rf $BUILD_DIR/scripts && \
    echo "Starting Planetiler" && \
    java -Xmx4g -jar /opt/planetiler/planetiler-*-with-deps.jar --download=false --languages=de,en --use_wikidata=false --osm-path=data/sources/${COVERAGE}.osm.pbf --free_water_polygons_after_read=true --free_natural_earth_after_read=true --free_osm_after_read=true --free_lake_centerlines_after_read=true --tile_compression=${TILE_COMPRESSION} --maxzoom=${MAX_ZOOM} --building_merge_z13=false --render_maxzoom=${MAX_ZOOM} --exclude-layers=${EXCLUDE_LAYERS} $PLANETILER_OPTS  && \
    rm -rf /opt && \
    if test "${FORMAT}" = 'files' ; then \
      /usr/bin/mb-util --silent --image_format=pbf $BUILD_DIR/data/output.mbtiles $DATA_DIR/tiles ; \
    else \
      mv data/output.mbtiles $DATA_DIR/tiles.mbtiles ; \
    fi && \
# Cleanup
    cd / && rm -rf $BUILD_DIR /tmp/GeoTools && \
    apk del $BUILD_DEPS

# Restart from an empty image to get rid of layers
#FROM scratch
FROM alpine:3.18

ENV DATA_DIR=/data

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source https://github.com/cmahnke/map-tools

COPY --from=builder $DATA_DIR $DATA_DIR
