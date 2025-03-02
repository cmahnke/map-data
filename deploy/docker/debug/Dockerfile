ARG DATA_IMAGE=ghcr.io/cmahnke/map-data/goettingen:latest

FROM --platform=linux/amd64 ${DATA_IMAGE} AS data

FROM nginx:1.27

ENV DATA_DIR=/data
ENV NGINX_PORT=8080
ENV NGINX_HOST=localhost

LABEL maintainer="cmahnke@gmail.com"
LABEL org.opencontainers.image.source https://github.com/cmahnke/map-tools

COPY --from=data $DATA_DIR /usr/share/nginx/html

RUN sed -i -e "s/listen       80/listen       $NGINX_PORT/g" /etc/nginx/conf.d/default.conf
RUN sed -i -e "s/index  index.html index.htm;/index  index.html index.htm;\nautoindex on;/g" /etc/nginx/conf.d/default.conf


EXPOSE 8080
