# Ansible Base

This image contains an installation of the latest version of Ansible.

The original repo that spawned this project can be found [here](https://github.com/andygodish/ansible-base/edit/main/README.md).


## Configuration

Everything stems from the `ansible.cfg` configuration file. A little on some of the settings it configures:

1. inventory

- This defines a local inventory file that playbooks should utilize by default
- Points to ./inventory

2. roles_path

- This is the directory containing the roles used by your Ansible Project
- points to ./roles

## Dockerfile

Rather than running and maintaining Ansible on my local machine, I like spin up a Docker container with `sshpass` to allow ansible to execute remote commands on the target inventory.

- You can probably build on this by referencing [this repo](https://github.com/willhallonline/docker-ansible)
- Largely based on [this guide](https://iceburn.medium.com/run-ansible-with-docker-9eb27d75285b)

### Build Local Image

```
docker build -t ansible-base:local .
```

### Test Adhoc Command

For testing purposes, this adhoc command can be used to troubleshoot the verbose output.

```
sh ping-adhoc.sh
```

There's also a test playbook that accesses the ping role that can be executed with the following command:

```
docker run \
-v ${PWD}:/work:ro \
-v ${PWD}/roles:/root/.ansible/roles \
-v /tmp/.test-ssh:/root/.ssh \
--rm ansible-base:local ansible-playbook ping-playbook.yaml
```

*Make sure your `/tmp/.test-ssh` directory contains the proper key file*

```
mkdir /tmp/.test-ssh && cp ~/.ssh/id_rsa /tmp/.test-ssh
```

## Ansible Galaxy

Since Ansible is installed and properly configured within the container, you can utilize ansible-galaxy calls as seen below:

```
docker run \
-v ${PWD}:/work \
-v ${PWD}/roles:/root/.ansible/roles \
-v /tmp/.test-ssh:/root/.ssh \
--rm ansible-base:local ansible-galaxy install gantsign.oh-my-zsh
```

The ansible.cfg uses the `./roles` directory as its roles_path configuration, you should see the directory for the role created in that folder. 

```
docker run \
-v ${PWD}:/work \
-v ${PWD}/roles:/root/.ansible/roles \
-v /tmp/.test-ssh:/root/.ssh \
--rm ansible-base:local ansible-galaxy remove gantsign.oh-my-zsh
```
