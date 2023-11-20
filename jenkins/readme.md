# Jenkins configuration

## Build image

```sh
docker build --pull --rm -f "Dockerfile" -t dpurge/jdp-jenkins:latest . 
```

## Run the image

```sh
docker run -it -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home dpurge/jdp-jenkins:latest
```