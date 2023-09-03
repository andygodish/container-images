# Ansible Role: Vagrant

[![pipeline status](https://gitlab.com/enmanuelmoreira/ansible-role-vagrant/badges/main/pipeline.svg)](https://gitlab.com/enmanuelmoreira/ansible-role-vagrant/-/commits/main)

This role installs [Vagrant](https://www.vagrantup.com/) application on any supported host.

## TODO:

- Plugin Versioning **(PARTIALLY SOLVED)**
- List of all plugins available

## Requirements

None.

## Installing

The role can be installed by running the following command:

```bash
git clone https://gitlab.com/enmanuelmoreira/ansible-role-vagrant enmanuelmoreira.vagrant
```

Add the following line into your `ansible.cfg` file:

```bash
[defaults]
role_path = ../
```

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    vagrant_package_state: present
    
    vagrant_plugins: []
    # - vagrant-reload

    # Installs specific vagrant plugins version.
    vagrant_plugins_with_version: []
    #  - name: vagrant-disksize
    #    version: 0.1.2

    vagrant_plugins_state: present
    vagrant_plugins_user: ""

A list of all Vagrant plugins can be checked out at this link: <https://rubygems.org/search?query=vagrant>

This configures the default provider Vagrant will use. Documentation: <https://www.vagrantup.com/docs/providers>.  

Providers available: libvirt, virtualbox, hyper-v.  

    vagrant_default_provider: "virtualbox"

Some features that aren't ready for release can be enabled through this feature flag.

    vagrant_experimental: "1"

If this is set to any value, then Vagrant will force colored output, even if it detected that there is no TTY or the current environment does not support it.

    vagrant_force_color: "1"

If this is set, Vagrant will not perform any parallel operations (such as parallel box provisioning). All operations will be performed in serial.

    vagrant_no_parallel: "1"

## Dependencies

None.

## Example Playbook

    - hosts: all
      become: yes
      roles:
        - role: enmanuelmoreira.vagrant

## License

MIT / BSD
