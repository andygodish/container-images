# Ansible Role: Packer

[![pipeline status](https://gitlab.com/enmanuelmoreira/ansible-role-packer/badges/main/pipeline.svg)](https://gitlab.com/enmanuelmoreira/ansible-role-packer/-/commits/main)

This role installs [Packer](https://www.packer.io/) application on any supported host.

## Requirements

None.

## Installing

The role can be installed by running the following command:

```bash
git clone https://gitlab.com/enmanuelmoreira/ansible-role-packer enmanuelmoreira.packer
```

Add the following line into your `ansible.cfg` file:

```bash
[defaults]
role_path = ../
```

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    packer_package_name: packer
    packer_package_state: present

    # Packer depends on two environment variables being configured for activate logs.
    # These two variables are PACKER_LOG and PACKER_LOG_PATH, both need
    # to be configured our no logging will occur.
    packer_activate_log: "1"
    packer_log_path: "/var/log/packer.log"

## Dependencies

None.

## Example Playbook

    - hosts: all
      become: yes
      roles:
        - role: enmanuelmoreira.packer

## License

MIT / BSD
