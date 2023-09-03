# Ping

Simple playbook for testing an ansible configuration against infrastructure. 

## Usage

### Dev

When building, use the `--target dev` flag. 

```
cd python/ansible/ping
```
```
docker build -t ping:dev --target dev .
```

```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm ping:dev /bin/bash
```

### Prod

Buiild sans `--target dev`.

```
cd python/ansible/ping
```
```
docker build -t ping:dev .
```
```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm ping:prod
```