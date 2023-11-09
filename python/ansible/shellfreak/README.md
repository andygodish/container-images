# Shellfreak

- [Ansible Galaxy](https://galaxy.ansible.com/ui/repo/published/drew1kun/shellfreak/)

## Usage

### OhMyZsh

After running this module, you will be prompted to configure the Powerlevel10k theme. You can run the wizard anytime by running `p10k configure`.

- preferences: n, n, n, y, 1 (Lean), 1 (Unicode), 1 (256 colors), n, 1, 1, 1, n, 1, y

### Dev

When building, use the `--target dev` flag. 

```
cd python/ansible/ping
```
```
docker build -t shellfreak --target dev .
```

```
docker run -it \
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v ${PWD}/collections:/home/appuser/.ansible/collections \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm shellfreak /bin/bash
```

### Prod

Build sans `--target dev`.

From the root of this repo:
```
docker build -t shellfreak -f ./python/ansible/docker/dockerfile .docker build -t ping:prod .
```

Now you only need to supply the ssh key for your hosts since the build target (dockerfile) copies the content of the ansible project in the container image:

```
docker run -it -v /tmp/.test-ssh:/home/appuser/.ssh \              
--rm docker:prod
```
