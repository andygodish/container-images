# container-images

Base image that I use frequently for my projects.

### Naming Convention

The directory structure in this repo should match the naming convention derived from the `docker pull` command you would use to download an image from its public registry. For example, the `debian:12-slim` image from [Docker Hub](https://hub.docker.com/_/debian/tags): 

```
docker pull debian:12-slim
```

Because this public image is hosted on docker hub, the `docker.io` registry prefix is implied. We reflect this in the directory structure by omitting a `./docker.io` directory. Therefore, the new image should be stored in the ./debian/12-slim directory. The image *tag* will prefix the dockerfile. 

```
debian
├── 12-slim.dockerfile
└── README.md
```

Base images from other public registries should include a parent directory representing the name of the registry. For example, version 7.0 of the dotnet sdk is pulled from the `mcr.microsoft.com` registry. The directory structure for our modified base image would be:

```
# docker pull mcr.microsoft.com/dotnet/sdk:7.0

mcr.microsoft.com
└── dotnet
    └── sdk
        ├── 7.0.dockerfile
        └── README.md
```

#### Builds that use a custom base image

If a product team uses one of our custom base images, the image should be stored in a directory named after the service with a descriptive name. For example, the `node:16-bookworm-slim` image is used as the base image for the `freerideautomation` app. The directory structure for this image would be:

```
/base/node/16-bookworm-slim/freerideautomation:latest
```

##### Tagging Custom Builds

TODO 

- I would like to include a latest tag on every rebuild along side some other for of tag, possibly the date. The main point of consideration is going to be storage. How many simple updates of an image to we want to keep in our repos?

- Automated image build will probably take place 1x per month.

#### Building the New Base Images

First, clone this repo and navigate to the directory containing the relevant Dockerfile and build the image, then execute the following docker command:

```
docker build -t base/<image-name>:<image-tag> -f <image-tag>.dockerfile .
```

Test by running the a container based on the newly built image:

```
docker run -it --rm base/<image-name>:<image-tag>
```

#### Pushing the New Base Images

> Automation via GitHub actions will be used for this process in the future.

See the `.github/workflows` directory for more details.

### Image Updates

Images should be updated on a regular basis to ensure that they are up to date with the latest security patches. GitHub actions workflows should be built to automatically update images on a regular basis.

### Image User

Images should be built with a non-root user. The user should be named `appuser` and have a UID of `1000`.

In some instances, a user will already be created using a uid of `1000`. For example, `node:16-bookworm-slim` has a *node* user with a uid of `1000`. In this image, appuser was assigned `1001`:

```
# cat /etc/passwd

node:x:1000:1000::/home/node:/bin/bash
appuser:x:1001:1001::/home/appuser:/bin/bash
```

```
# Dockerfile

RUN useradd -ms /bin/bash -u 1001 appuser
```



