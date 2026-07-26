FROM ghcr.io/mapproxy/mapproxy/mapproxy:7.0.0 AS builder

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source=https://github.com/cmahnke/map-data

ENV DATA_DIR=/data

USER root

RUN mkdir -p $DATA_DIR/tiles && \
    chown -R mapproxy:mapproxy $DATA_DIR

USER mapproxy:mapproxy

COPY deploy/docker/data/goettingen-topo/config/mapproxy.yaml /etc/mapproxy.yaml
COPY deploy/docker/data/goettingen-topo/config/seed.yaml /etc/seed.yaml

RUN mapproxy-seed -s /etc/seed.yaml -f /etc/mapproxy.yaml

FROM alpine:3.24

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source=https://github.com/cmahnke/map-data

ENV DATA_DIR=/data

COPY --from=builder $DATA_DIR $DATA_DIR
