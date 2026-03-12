- this docker image can be used to skip the installation of all the tools required for 18S mNGS analysis
- required database should be prepared separately.
- 

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
  # please change $PWD to directory you want to work with
  docker run \
    --rm \
     -d \
     -v $PWD:/data \
     -p 28555:8555 \
     env18s 
# if you want to stop, close container from docker desktop
  ```
 
## access jupyter
  ```bash
  http://localhost:28555/lab/   
  ```
## put required tool
 ```bash 
 # retrieve from github repository for each tool.
 # if you put in /data/tool
 # /data/tool/minibar.py
 python /data/tool/minibar.py -h
 # /data/tool/amplicon_sorter.py
 python /data/tool/amplicon_sorter.py -h
 
 ```

 ## check other tools
 ```bash 
  seqkit --help
  porechop --help
 ```
