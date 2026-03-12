## build docker image
1. this dockerfile was tested with 86x64 and arm64(apple silicon, with docker desktop)
- git clone this repository

```bash
git clone ${URL_FOR_THIS_GITREPO_HERE}
```
- enable docker build (for docker-desktop, docker engine should be started.)
- open terminal, move to directory which store Dockerfile, build docker image locally.
  ```bash
  #move to where Dockerfile is located
  cd <<18SmNGS>>/docker
  #docker build -t %AnyNameYouWantTouseForThisDockerImage% .
  docker build -t env18s .
  ```

## run docker image
  ```bash
  #check if the image is built
  docker images
  # you should have env18S image in the list

  #bind data directory if required.
  # Run with port mappings:
  #  - Jupyter: host 28555 -> container 8555
  docker run \
     -e SSH_USER=%myuser% -e SSH_PASSWORD=%mypass% \
    --rm \
     -v %YOURDATA_DIR%:/data \
     -p 28555:8555 \
     env18s
# don't shutdown terminal, or disown process.
  ```
 
## access jupyter
  ```bash
  http://localhost:28555/lab/
  ```
