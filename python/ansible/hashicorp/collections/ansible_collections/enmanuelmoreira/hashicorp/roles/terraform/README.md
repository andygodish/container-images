# Ansible Role: Terraform

[![pipeline status](https://gitlab.com/enmanuelmoreira/ansible-role-terraform/badges/main/pipeline.svg)](https://gitlab.com/enmanuelmoreira/ansible-role-terraform/-/commits/main)

This role installs [Terraform](https://www.terraform.io/) application on any supported host.

## Requirements

None.

## Installing

The role can be installed by running the following command:

```bash
git clone https://gitlab.com/enmanuelmoreira/ansible-role-terraform enmanuelmoreira.terraform
```

Add the following line into your `ansible.cfg` file:

```bash
[defaults]
role_path = ../
```

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    terraform_package_name: terraform
    terraform_package_state: present

## Dependencies

None.

## Example Playbook

    - hosts: all
      become: yes
      roles:
        - role: enmanuelmoreira.terraform

## License

MIT / BSD
