# Map data

## Build map debug server

Set the data image using a `--build-arg`

```
docker build -f deploy/docker/debug/Dockerfile -t map-debug:latest .
```

### Running

```
docker run -p8080:8080 -it map-debug:latest
```

## Build Göttingen data image

```
docker build -f deploy/docker/data/Dockerfile -t ghcr.io/cmahnke/map-data/goettingen:latest --build-arg COVERAGE=goettingen.json --build-arg MAX_ZOOM=15 --build-arg EXCLUDE_LAYERS="" --build-arg FILTER_BUILDINGS=false  .
```
