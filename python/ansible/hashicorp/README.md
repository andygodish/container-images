# hashicorp

Installs Hashicorp tools on a remote hosts.

### Notes
- I added a new role called packer-log that creates a /var/log/packer.log file and sets the owner to "{{  ansible_user }}". With just the installation from the collection, the packer cli complains that it is unable to open the packer.log file. This is a workaround for that issue.

- See commit `3cd4422b8b09677b0744d0b898a0f691526ed0c7` - these are the packer role steps I had to add `become: yes` to in order to properly execute the role. I'm not sure if an ansible-galaxy update will wipe these changes.q

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

