# Docker

Installs docker on designated hosts. 

## Usage

### Dev

When building, use the `--target dev` flag. 

```
cd python/ansible/ping
```
```
docker build -t docker:dev --target dev .
```

```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm docker:dev /bin/bash
```

### Prod

Buiild sans `--target dev`.

```
cd python/ansible/docker
```
```
docker build -t ping:prod .
```
```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm docker:prod
```