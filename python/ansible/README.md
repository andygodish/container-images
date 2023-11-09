# Ansible Base

This image contains an installation of the `latest` version of Ansible.

The original repo that spawned this project can be found [here](https://github.com/andygodish/ansible-base/edit/main/README.md).

This "base" ansible image contains child directories contating playbooks and roles for various tasks. Both development cases involving the installation of individual applications and their dependencies as well as projects that combine multiple roles into a single playbook.

In most cases, ansible-galaxy is used as an entrypoint command to install or upgrade particular roles. Those roles are then edited to fit the needs of the project. 

This repo does build standalone images for each project, but there are configuration values and variables that need to be set in either the hosts.ini file or within the ansible roles themselves. This project works best when each image is built and run locally. 

See the volume mounts `-v` in the docker run commands listed below for more information.

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
-v ${PWD}:/home/appuser/app \
-v ${PWD}/roles:/home/appuser/.ansible/roles \
-v /tmp/.test-ssh:/home/appuser/.ssh \
--rm ansible-base:local ansible-playbook main.yaml
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

### Working with Remote Collections

I like to tailor remote collections and roles that I pull in to ansible galazy by making changes specific to my environments. For example, commenting out tasks that do not work with newer versions of an os I have installed on my target hosts. 

In the event that I want to capture updates from the upstream galaxy codebase, I can run the following:

```
ansible-galaxy collection install <collection> --force
```

This will override any changes that I have made to the collection itself. I can revert those changes to my previous commit by running, 

```
git reset --hard
```

It would make sense to create a new branch, force the update, and then resolve merge conflicts upon merging back into the main branch. 
