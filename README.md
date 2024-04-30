# NVM Docker for GCloud SDK and Terraform


## Build local docker image
```
docker build -t muneer2ishtech/gcloud:vX.Y.Z .
```

## Get docker image
```
docker pull muneer2ishtech/gcloud
```
or
```
docker pull muneer2ishtech/gcloud:latest
```

## Usage
```
docker run -it muneer2ishtech/gcloud
```
or
```
docker run -it muneer2ishtech/gcloud:latest
```

### With local folders available on docker and ports exposed
```
docker run \
  --name TODO_somename \
  --mount type=bind,source=/todo_path_on_local,target=/todo_path_on_docker \
  -it muneer2ishtech/gcloud:TODO_version
```
