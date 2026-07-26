FROM ghcr.io/mapproxy/mapproxy/mapproxy:7.0.0 AS builder

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source=https://github.com/cmahnke/map-data

USER root

RUN mkdir -p /data/topo-map && \
    chown -R mapproxy:mapproxy /data

USER mapproxy:mapproxy

COPY deploy/docker/data/goettingen-topo/config/mapproxy.yaml /etc/mapproxy.yaml
COPY deploy/docker/data/goettingen-topo/config/seed.yaml /etc/seed.yaml

RUN mapproxy-seed -s /etc/seed.yaml -f /etc/mapproxy.yaml

FROM alpine:3.24

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source=https://github.com/cmahnke/map-data

COPY --from=builder /data/topo-map /data/map
