# hashicorp

Installs Hashicorp tools on a remote hosts.

## Usage

### Dev

When building, use the `--target dev` flag. 

```
cd python/ansible/hashicorp
```
```
docker build -t hashicorp:dev --target dev .
```

```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v ${PWD}/collections:/home/appuser/.ansible/collections \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm hashicorp:dev /bin/bash
```

### Prod

Build sans --target dev.

From the root of this repo:
```
docker build -t hashicorp:prod -f ./python/ansible/hashicorp/dockerfile .docker build -t hashicorp:prod .
```

Now you only need to supply the ssh key for your hosts since the build target (dockerfile) copies the content of the ansible project in the container image:

```
docker run -it -v /tmp/.test-ssh:/home/appuser/.ssh \              
--rm hashicorp:prod
```

**Problem****

The hosts.ini file is now statically built. Don't do this without overriding it.

